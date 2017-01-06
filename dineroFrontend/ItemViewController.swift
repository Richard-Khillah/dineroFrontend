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
        let urlRequest = URLRequest(url: URL(string: "http://localhost:5000/item/")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // make sure there was no error in iniating request
            if error != nil {
                print(error)
                return
            }
            
            // initialize items array
            self.items = [Item]()
        
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                if let itemsFromJson = json["items"] as? [[String:AnyObject]] {
                    for itemFromJson in itemsFromJson {
                        let item = Item()
                        
                        if let name = itemFromJson[""] as? String, let description = itemFromJson["description"] as? String, let category = itemFromJson["category"] as? String, let cost = itemFromJson["cost"] as? Float, let id = itemFromJson["id"] as? Int {
                            
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
}
