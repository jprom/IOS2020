//
//  Transaction.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/26/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import Foundation
import RealmSwift

class Transaction: Object  {
    @objc dynamic var id                        = UUID().uuidString
    @objc dynamic var transactionDescription    = ""
    @objc dynamic var transactionAmount         = 0
    
    convenience init(transactionDescription: String, transactionAmount: Int){
        self.init()
        self.transactionDescription     = transactionDescription
        self.transactionAmount          = transactionAmount
    }
    
    override static func primaryKey() -> String? {
           return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}
