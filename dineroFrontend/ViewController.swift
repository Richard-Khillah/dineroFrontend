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
        performSegue(withIdentifier: "toLoginRegisterStoryboard", sender: self)
    }
}

