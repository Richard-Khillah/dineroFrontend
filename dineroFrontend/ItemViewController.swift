//
//  ItemViewController.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/5/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    // array of items found on the server
    var items: [Item]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
    }
    
    func fetchItems() {
        
        // Generate session authorization information to gather information
        // from the server.
        let userToken = UserDefaults.standard.string(forKey: "userToken")
        let bearerToken = "Bearer " + userToken!
        
        
        if let url = AuthURL.getItemURL {
            // Create Session Object
            let session = URLSession.shared
            
            // Create request, method and header fields
            var urlRequest = URLRequest(url: URL(string: "http://localhost:5000/item/")!)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.addValue(bearerToken, forHTTPHeaderField: "Authorization")
            
            // Create data task to fetch items
            let task = session.dataTask(with: urlRequest, completionHandler: {
                (data, response, error) in
                
                guard error == nil else {
                    print("error line 47")
                    return
                }
                
                guard let data = data else {
                    print("Error with data = data")
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        print("line 58 print(json) = ")
                        print(json)
                        
                        if let status = json["status"] as? String {
                            
                            if status == "success" {
                                
                                if let data = json["data"] as? [[String:Any]]{
                                    
                                    // initialize items array
                                    self.items = [Item]()
                                    
                                    for item in data {
                                        if let name = item["name"] as? String, let description = item["description"] as? String, let category = item["category"] as? String, let cost = item["cost"] as? Float, let id = item["id"] as? Int {
                                            
                                            // Create an Item
                                            let item = Item()
                                            
                                            item.name = name
                                            item.desc = description
                                            item.category = category
                                            item.cost = cost
                                            item.id = id
                                            
                                            self.items?.append(item)
                                        }
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                } catch let error {
                    print("Error in catch of first do/catch in task.")
                    print(error)
                    return
                }
            })
            task.resume()
        }
    }
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        fetchItems()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        if let item = (self.items?[indexPath.item])! as? Item {
         
            cell.nameLabel.text = item.name
            cell.costLabel.text = String(describing: item.cost!)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If there are no items, return 0
        return items?.count ?? 0
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if logout() {
            self.dismiss(animated: true, completion: nil)
        } else {
            alert(message: "Error loggin out")
        }
    }
}
