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
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    let reservations = List<Reservation>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
