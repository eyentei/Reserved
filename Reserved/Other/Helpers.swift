//
//  Helpers.swift
//  Reserved
//
//  Created by Elena Orshanskaya on 15.03.2020.
//  Copyright © 2020 Мария Коровина. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func isPhone() -> Bool {
         // let phoneRegex = "^((+7|7|8)+([0-9]){10})$"
       //  let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
         //return phoneTest.evaluate(with: self)
        let phoneRegEx = "^[7-8]-9[0-9]{2}-[0-9]{3}-[0-9]{2}-[0-9]{2}"
        var phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneNumber.evaluate(with: self)
        
        
        

    }
}
