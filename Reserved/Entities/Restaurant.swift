//
//  Restaurant.swift
//  Reserved
//
//  Created by Мария Коровина on 07/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import Foundation
import RealmSwift

class Restaurant: Object {
    @objc dynamic var id:String = UUID().uuidString
    @objc dynamic var pic = ""
    @objc dynamic var name = ""
    @objc dynamic var price = ""
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    @objc dynamic var phone = "+1(999)123-12-22"
    @objc dynamic var website = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}