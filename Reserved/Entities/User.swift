//
//  File.swift
//  Reserved
//
//  Created by Мария Коровина on 07/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var pic = ""
    @objc dynamic var password: String = ""
    @objc dynamic var number: String = ""

    let reservations = List<Reservation>()
 
    convenience init(name: String, email: String, password: String) {
        self.init()
        self.name = name
        self.email = email
        self.password = password
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}
