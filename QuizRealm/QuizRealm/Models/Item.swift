//
//  Item.swift
//  QuizRealm
//
//  Created by Juan Pablo Rosales on 4/7/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var tagNumber = 0
    @objc dynamic var name: String = ""
    @objc dynamic var purchaseDate = Date()
    @objc dynamic var quantity = 0
    
    convenience init(tagNumber: Int, name: String, quantity: Int ){
        self.init()
        self.tagNumber = tagNumber
        self.name = name
        self.quantity = quantity
    }
    
    override static func primaryKey() -> String? {
        return "tagNumber"
    }
    
    override static func indexedProperties() -> [String] {
        return ["tagNumber"]
    }
    
    
}
