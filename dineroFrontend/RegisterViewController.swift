//
//  RegisterViewController.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/3/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController, UserSendingData {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userUsernameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userRetypePasswordTextField: UITextField!
    @IBOutlet weak var userRoleLabelFromPicker: UILabel!
    
    var emails = [String]()
    var passwords = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            request.returnsObjectsAsFaults = false
            do {
                
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let email = result.value(forKey: "email") as? String{
                            self.emails.append(email)
                            print(self.emails)
                        }
                        if let password = result.value(forKey: "password") as? String{
                           self.passwords.append(password)
                            print(self.passwords)
                        }
                    }
                }
            } catch {
                self.alert(message: "Error occured while fetching information from database")
            }
        } catch {
            print("no items in core data")
        }
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userName = userNameTextField.text
        let userUsername = userUsernameTextField.text
        let userPassword = userPasswordTextField.text
        let userRetypePassword = userRetypePasswordTextField.text
        let userRole = userRoleLabelFromPicker.text
        
        // Check for empty fields
        if userEmail!.isEmpty || userName!.isEmpty || userUsername!.isEmpty || userPassword!.isEmpty || userRetypePassword!.isEmpty || userRole == "--Select Role--" {
            alert(message: "All fields must be filled in before registering.")
            return
        }
        
        // Check wether a user exists with the same username
        
        // Ensure passwords entered are the same:
        if userPassword == userRetypePassword {
            
            // Add user to System
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            
            newUser.setValue(userEmail, forKey: "email")
            newUser.setValue(userName, forKey: "name")
            newUser.setValue(userUsername, forKey: "username")
            newUser.setValue(userPassword, forKey: "password")
            newUser.setValue(userRole, forKey: "role")
            
            do {
                
                try context.save()
                
                let myAlert = UIAlertController(title: "Alert", message: "Success", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                    { action in self.dismiss(animated: true, completion: nil) }
                
                myAlert.addAction(action)
                self.present(myAlert, animated: true, completion: nil)
                
            } catch {
                
                alert(message: "Error Occured while adding user to system.")
            }
        }
    }
    
    func alert(message: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        myAlert.addAction(action)
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRolePopupView" {
            let rolePopupViewController: RolePopupViewController = segue.destination as! RolePopupViewController
            rolePopupViewController.delegate = self
        }
    }
    
    func sendingDataFromUser(data: String) {
        userRoleLabelFromPicker.text = data
    }
}
