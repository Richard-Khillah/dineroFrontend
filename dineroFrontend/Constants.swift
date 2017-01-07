//
//  Constants.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/6/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import Foundation

struct AuthURL {
    static let registerURL: URL? = URL(string: "http://127.0.0.1:5000/auth/register")
    
    static let loginURL: URL? = URL(string: "http://127.0.0.1:5000/auth/login")
    
    static let getItemURL: URL? = URL(string: "http://localhost:5000/item/")
    
    
}
