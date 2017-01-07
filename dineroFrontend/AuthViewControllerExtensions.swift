//
//  AuthViewControllerExtensions.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/6/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    func logout() -> Bool{
        var loggedOut = false
        
        if !loggedOut {
            UserDefaults.standard.set("", forKey: "userRole")
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
            loggedOut = true
        }
        return loggedOut
    }
    
}
