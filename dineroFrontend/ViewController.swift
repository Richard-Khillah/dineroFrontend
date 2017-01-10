//
//  ViewController.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/3/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("inside viewDidLoad()")
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        print(isUserLoggedIn)
        
        let userRole = UserDefaults.standard.string(forKey: "userRole")
        print(userRole!)
        
        if isUserLoggedIn {
            if userRole! == "owner" {
                performSegue(withIdentifier: "toServerStoryboard", sender: self)
            }
        } else {
            
            performSegue(withIdentifier: "toLoginRegisterStoryboard", sender: self)
        }
    }
    
    func unwindToProtected(segue: UIStoryboardSegue) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
}

