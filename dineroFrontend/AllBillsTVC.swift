//
//  AllBillsTVC.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/8/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

class AllBillsTVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var bills: [Bill]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBills()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(bills?.count)
        return bills?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllBillsCell", for: indexPath) as! AllBillsCell
        
        // Recall: bill is of type Bill
        if let bill = (bills?[indexPath.item]) {
            cell.customerNameLabel.text = bill.customerName
            cell.billTotalLabel.text = String(describing: bill.billTotal)
        }
        
        return cell
    }
    
    
    // MARK: - IBAction Buttons
    
    @IBAction func addBillButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        if logout() {
            
        }
    }
    
    
    // MARK: - fetch functions
    
    func get(customerInformation forCustomerName: String) -> (Int, Float)? {
        
        // What was this needed for?
        return nil
    }
    
    func fetchBills() {
        
        // Generate session authorization information to gather information
        // from the server.
        let userToken = UserDefaults.standard.string(forKey: "userToken")
        let bearerToken = "Bearer " + userToken!
        
        
        if let url = AuthURL.getBillsURL {
            // Create Session Object
            let session = URLSession.shared
            
            // Create request, method and header fields
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.addValue(bearerToken, forHTTPHeaderField: "Authorization")
            
            // Create data task to fetch items
            let task = session.dataTask(with: urlRequest, completionHandler: {
                (data, response, error) in
                
                guard error == nil else {
                    print("guard fail: error != nil")
                    return
                }
                
                guard let data = data else {
                    print("guard fail: let data = data")
                    return
                }
                
                self.bills = [Bill]()
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        //print("All Bills json = ")
                        //print(json)
                        
                        if let status = json["status"] as? String, status == "success", let data = json["data"] as? [String: Any], let bills = data["bills"] as? [[String: Any]] {
                            print("status = \(status)")
                            //print("data = \(data)")
                            //print("bills as? [[String: Any]] = \(bills)")
 
                            for bill in bills {
                                print("bill = \(bill)")
                                //print(Mirror(reflecting: bill).subjectType)
                                
                                if let billId = bill["id"] as? Int, let receiptNumber = bill["receipt_number"] as? String, let paid = bill["paid"] as? Bool, let customer = bill["customer"] as? [String: Any], let name = customer["name"] as? String {
                                    
                                    //let name = customer["name"] as? String
                                    let bill = Bill()

                                    // TODO: - create fetch items function. perhaps as an extension/global function
                                    // TODO: - Determine whether paid receipt goes to user from Frontend or stripe
                                    // TODO: - fetch bill items
                                    bill.billId = billId
                                    bill.receiptNumber = receiptNumber
                                    bill.customerName = name
                                    bill.paid = paid
                                    
                                    self.fetchBillItems(bill: bill)
                                    
                                    self.bills?.append(bill)
                                    
                                    for bill in self.bills! {
                                        print("name = \(bill.customerName)")
                                        print("receiptNumber = \(bill.receiptNumber)")
                                        print("billId = \(bill.billId)")
                                        print("paid = \(bill.paid)")
                                        //for item in bill.billItems {
                                          //  print("item name = \(item.name)")
                                            //print("item cost = \(item.cost)")
                                        //}
                                    }
                                    

                                    print("end current bills?.append(bill)")
                                    
                                }
                            }
                            
                            // After Parsing data, relad the table view on the main thread
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
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

    
    func fetchBillItems(bill: Bill?) {
        print("Entering fetch BillItems")
        
        // Generate session authorization information to gather information
        // from the server.
        let userToken = UserDefaults.standard.string(forKey: "userToken")
        let bearerToken = "Bearer " + userToken!
        
        
        if let url = AuthURL.getItemURL {
            // Create Session Object
            let session = URLSession.shared
            
            // Create request, method and header fields
            var urlRequest = URLRequest(url: url)
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
                        //print("line 58 print(json) = ")
                        //print(json)
                        
                        if let status = json["status"] as? String { // remove 1 start
                            
                            if status == "success" { // remove 2 start
                                print("fetchBillItems, status == success")
                                
                                if let items = json["items"] as? [[String:Any]] { // remove 3 start
                                    print("items = \(items)")
                                    
                                    // initialize items array
                                    //var billItems = [Item]()
                                    
                                    for item in items {
                                        if let name = item["name"] as? String, let description = item["description"] as? String, let category = item["category"] as? String, let cost = item["cost"] as? Float, let id = item["id"] as? Int {
                                            
                                            // Create an Item
                                            let item = Item()
                                            
                                            item.name = name
                                            item.desc = description
                                            item.category = category
                                            item.cost = cost
                                            item.id = id
                                            
                                            print("start item")
                                            print("item name = \(name)")
                                            print("item.name = \(item.name)")
                                            print("end current Item")
                                            
                                            //self.bills?[indexPath!].billItems?.append(item)
                                            bill?.billItems?.append(item)
                                            print("apended item to bill")
                                            //billItems.append(item)
                                        }
                                    }
                                } // remove 3 end
                            } // remove 2 end
                        } // remove 1 end
                    }
                } catch let error {
                    print("Error in catch of first do/catch in task.")
                    print(error)
                    return
                }
            })
            task.resume()
        }
        print("exiting fetchBillItems")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    

}
