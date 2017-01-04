//
//  RolePopupViewController.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/3/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

protocol UserSendingData {
    func sendingDataFromUser(data: String)
}

class RolePopupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let userRoleOptions = ["--Select Role--", "Customer", "Server", "Manager", "Owner", "Admin"]
    
    @IBOutlet weak var userRolePicker: UIPickerView!
    
    var delegate: UserSendingData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userRolePicker.delegate = self
        userRolePicker.dataSource = self
        
        print(userRoleOptions)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userRoleOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userRoleOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.sendingDataFromUser(data: userRoleOptions[row])
    }
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
