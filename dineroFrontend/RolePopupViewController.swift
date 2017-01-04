//
//  RolePopupViewController.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/3/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

class RolePopupViewController: UIViewController {
    
    @IBOutlet weak var userRolePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
