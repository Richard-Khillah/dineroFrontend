//
//  ErrorViewControllerExtension.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/6/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentError(inFileName: String, startingOnLineNumber: Int, withErrorMessage: Error?) {
        print("START error::\(inFileName):line \(startingOnLineNumber)")
        print(withErrorMessage!.localizedDescription)
        print("END error::\(inFileName)")
    }
    
}
