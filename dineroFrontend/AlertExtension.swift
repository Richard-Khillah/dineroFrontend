//
//  AlertExtension.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/4/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController
{
    func alert(message: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        myAlert.addAction(action)
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
    func get(CoreData entityName: String, forKey1: String, forKey2: String?) -> ([String]?, [String]?)
    {
        var key1arr = [String]()
        var key2arr = [String]()
        
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            request.returnsObjectsAsFaults = false
            do {
                
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let arg1 = result.value(forKey: forKey1) as? String{
                            key1arr.append(arg1)
                            //print(key1arr)
                        }
                        if let arg2 = result.value(forKey: forKey2!) as? String{
                            key2arr.append(arg2)
                            //print(key2arr)
                        }
                    }
                }
            } catch {
                self.alert(message: "Error occured while fetching information from database")
            }
        }
        return (key1arr, key2arr)
    }

}
