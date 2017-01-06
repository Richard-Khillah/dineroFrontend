//
//  LoginViewController.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/3/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!

    
    var storedEmails = [String]()
    var storedTokens = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (storedEmails, storedTokens) = get(CoreDataDbEmailToken: "DbEmailToken", forKeyEmail: "email", forKeyToken: "token")
        
        print("emails = \(storedEmails); tokens = \(storedTokens)")
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userEmail = userEmailTextField.text?.lowercased()
        let userPassword = userPasswordTextField.text
        
        // Retrieve the token from CoreData entity DbEmailToken
        if let emailIndex = storedEmails.index(of: userEmail!) {
            let token = storedTokens[emailIndex]
            
            // use the key to log the user in.
            let loginForm = ["email": userEmail,"password": userPassword]
            if let url = AuthURL.loginURL {
                
                // Create Session Object
                let session = URLSession.shared
                
                // Create the request and request method
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                
                // Format the login form and add it to the request body
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: loginForm, options: .prettyPrinted)
                    
                } catch let error {
                    print(error)
                }
                
                // Set headers then create data task
                let bearerToken = "Bearer " + token
                print(bearerToken)
                
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
                
                let task = session.dataTask(with: request as URLRequest, completionHandler:  { (data, response, error) in
                    
                    guard error == nil else {
                        print("Error: error != nil")
                        return
                    }
                    
                    guard let data = data else {
                        print("Error: error processing data")
                        return
                    }
                    
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                            print("made json")
                            print(json)
                            
                            // implement handling of json
                            if let message = json["message"] as? String {
                                print(message)
                                
                                if message == "successfully logged in." {
                                    if let data = json["data"] as? [String:Any] {
                                        
                                        if let returnedToken = data["token"] as? String {
                                            if token == returnedToken {
                                                print("Tokens Match and user is now logged in")
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                })
                task.resume()
            }
        }
    }
}
