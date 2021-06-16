//
//  ViewController.swift
//  jasonParsing
//
//  Created by minal borole on 16/06/21.
//

import UIKit

struct Post: Decodable{
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

class ViewController: UIViewController {
    var postArray: [Post] = []

    @IBOutlet weak var postTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJason()
        // Do any additional setup after loading the view.
    }
    
    func parseJason(){
        let str = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error )in
            if error == nil{
                do{
                    self.postArray = try JSONDecoder().decode([Post].self, from: data!)
                    DispatchQueue.main.async {
                        self.postTable.reloadData()
                    }
                    
                }
                catch{
                    print("something went wrong")
                }
            }
        }.resume()
    }


}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = postArray[indexPath.row].title
        cell?.detailTextLabel?.text = postArray[indexPath.row].body
        return cell!
    }
    
    
}
