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
        
        
        var urlRequest = URLRequest(url: URL(string: "http://localhost:5000/item/")!)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(bearerToken, forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                print("START error::ItemViewController.swift:")
                print(error!.localizedDescription)
                print("END error::ItemViewContoller.swift")
                return
            }
            guard let data = data else {
                print("Error::ItemViewController.swift:line 42: `guard let data = data` failed.")
                return
            }
            
            do {
                
                // Create json object from data
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                
                print(":ItemViewController.Swift::fetchItems(): `line 55:")
                print(json)
                
                // imlement handling of json
                if let status = json["status"] {
                    print(":ItemViewController.Swift::fetchItems(): `line 60`")
                }
                
                if let itemsFromJson = json["data"] as? [String:Any] {
                    print("itemsFromJson = \(itemsFromJson)")
                    for itemFromJson in (itemsFromJson as? [String: Any]) {
                        let item = Item()
                        
                        if let name = itemFromJson["name"] as? String, let description = itemFromJson["description"] as? String, let category = itemFromJson["category"] as? String, let cost = itemFromJson["cost"] as? Float, let id = itemFromJson["id"] as? Int {
                            
                            // initialize items array
                            self.items = [Item]()
                            
                            item.name = name
                            item.desc = description
                            item.category = category
                            item.cost = cost
                            item.id = id
                        }
                        self.items?.append(item)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error)
                return
            }
        }
        task.resume()
    }
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        fetchItems()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        cell.nameLabel.text = self.items?[indexPath.item].name
        cell.costLabel.text = self.items?[indexPath.item].name
        
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
