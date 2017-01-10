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
    
    static let getBillsURL: URL? = URL(string: "http://localhost:5000/bills/restaurant/1")
    
    // Before using getBillItemsURL to run a query, billId must be appended to the
    // url path. e.g. for bill id 1, string:"http://localhost:5000/bills/1"
    // TODO: - Remove the hyperlink for the http on the previous line.
    // TODO: - In all code blocks that use the following url, remove the trailing 1 and append the bill id
    static let getBillItemsURL: URL? = URL(string: "http://localhost:5000/bills/1")
    
    
}
