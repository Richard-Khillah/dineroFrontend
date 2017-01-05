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
        
        // retrieve emails and passwords and store locally
        (emails, passwords) = get(CoreData: "Users", forKey1: "email", forKey2: "password")
        
        print(emails)
        print(passwords)
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
        
        // Ensure passwords entered are the same and save with CoreData:
        /*
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
        */
        if userPassword == userRetypePassword {
            // Declare the registration form
            let registrationForm = ["name": userName, "username": userUsername, "password": userPassword, "email": userEmail, "restaurant_id": 1] as [String : Any]
            //let registrationForm = "name=\(userName), username=\(userUsername), password=\(userPassword), email=\(userEmail)"
            
            // Create the url to send to
            if let url = URL(string: "http://127.0.0.1:5000/auth/register") {
                
                // Create a session Object
                let session = URLSession.shared
                
                // Create the request and request method
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                
                // Format the registrationForm and add it to the request body
                do {
                    // pass a dictionary to nsdata object
                    request.httpBody = try JSONSerialization.data(withJSONObject: registrationForm, options: .prettyPrinted)
                    //request.httpBody = registrationForm.data(using: String.Encoding.utf8)
                    
                } catch let error {
                    print(error.localizedDescription)
                }
                
                // Set header
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                // Create dataTask using the session object to send data to the server
                let task = session.dataTask(with: request as URLRequest, completionHandler: {
                    data, response, error in
                    
                    guard error == nil else {
                        print("Error: alert != nil")
                        return
                    }
                    guard let data = data else {
                        print("Error: Not able to let data = data")
                        return
                    }
                    
                    do {
                        // Create json object from data
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
                            print("just before print(json)")
                            print(json)
                            // implement handling of json
                            
                            
                            
                        }
                    } catch let error {
                        print("catching error after task:")
                        print(error.localizedDescription)
                    }
                })
                task.resume()
                
            } else {
                alert(message: "Error creating url")
                return
            }
            
           
        alert(message: "Made it to the end of tapRegister")
    }
    
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
