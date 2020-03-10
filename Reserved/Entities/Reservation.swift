//
//  Reservation.swift
//  Reserved
//
//  Created by Мария Коровина on 07/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import Foundation
import RealmSwift

class Reservation: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var restaurant: Restaurant?
    @objc dynamic var time = Date()
    @objc dynamic var person: User?
    var tables = List<Int>()
    @objc dynamic var calendarEventId: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
