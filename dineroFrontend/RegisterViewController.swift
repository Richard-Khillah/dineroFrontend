//
//  RegisterViewController.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/3/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userUsernameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userRetypePasswordTextField: UITextField!
    @IBOutlet weak var userRoleLabelFromPicker: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func roleLabelTapped(_ sender: Any) {
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
