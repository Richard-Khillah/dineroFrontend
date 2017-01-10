//
//  Bill.swift
//  dineroFrontend
//
//  Created by Richard Khillah on 1/8/17.
//  Copyright © 2017 RK Inc. All rights reserved.
//

import UIKit

class Bill: NSObject {
    var billId: Int?
    var customerName: String?
    var billItemNumbers: [Int]?
    var paid: Bool?
    var receiptNumber: String?
    var billItems: [Item]?
    var billTotal: Float?
}
