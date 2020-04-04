//
//  Articulo.swift
//  Tarea#3
//
//  Created by Juan Pablo Rosales on 3/27/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import Foundation
import RealmSwift

class Producto : Object{
    
    @objc dynamic var identifier = NSUUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var quantity: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var date = Date()
    
    convenience init(name: String, quantity: Int, image: String){
        self.init()
        self.name = name
        self.quantity = quantity
        self.image = image
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }
}


