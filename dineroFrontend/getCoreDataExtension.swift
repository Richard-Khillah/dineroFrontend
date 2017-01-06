//
//  getCoreDataExtension.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/4/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController
{
    func get(CoreDataDbEmailToken forEntityName: String, forKeyEmail: String, forKeyToken: String) -> ([String], [String])
    {
        var keyEmails = [String]()
        var keyTokens = [String]()
        
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: forEntityName)
            request.returnsObjectsAsFaults = false
            
            do {
                
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        
                        if let email = result.value(forKey: forKeyEmail) as? String{
                            keyEmails.append(email)
                            //print(key1arr)
                        }
                        
                        if let token = result.value(forKey: forKeyToken) as? String{
                            keyTokens.append(token)
                            //print(key2arr)
                        }
                    }
                }
            } catch {
                self.alert(message: "Error occured while fetching information from database")
            }
        } catch {
            print("no items in core data")
        }
        
        return (keyEmails, keyTokens)
    }
    
    // MARK: - Delete All Data Records
    
    func deleteRecords(forEntityName: String) {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: forEntityName)
        
        let result = try! context.fetch(fetchRequest)
        
        for object in result {
            context.delete(object as! NSManagedObject)
        }
        
        do {
            try context.save()
            print("Delete CoreData Saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    // MARK: Get Context
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func save(NewCoreDataDbEmailToken forEntityName: String, forKeyEmail: String, forKeyToken: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newDbEmailToken = NSEntityDescription.insertNewObject(forEntityName: forEntityName, into: context)
        
        newDbEmailToken.setValue(forKeyEmail, forKey: "email")
        newDbEmailToken.setValue(forKeyToken, forKey: "token")
        
        do {
            
            try context.save()
            print("CoreData Successful Save")
            
        } catch {
            
            self.alert(message: "Error Occured while processing registration.")
            print("Not able to create a user.")
        } // end do/catch
    }
    
}
