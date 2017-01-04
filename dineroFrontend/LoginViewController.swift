//
//  LoginViewController.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/3/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userUsernameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        var storedUsernames = [String]()
        var storedPasswords = [String]()
        
        (storedUsernames, storedPasswords) = get(CoreData: "Users", forKey1: "username", forKey2: "password")
        
        let userUsername = userUsernameTextField.text?.lowercased()
        let userPassword = userPasswordTextField.text
    }
}
