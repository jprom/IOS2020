//
//  Budget.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/15/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import Foundation
import RealmSwift

class Budget: Object  {
    @objc dynamic var id                    = UUID().uuidString
    @objc dynamic var budgetName            = ""
    @objc dynamic var budgetPeriodicity     = ""
    @objc dynamic var budgetStartDate       = Date()
    @objc dynamic var budgetInitialAmount   = 0
    @objc dynamic var budgetTotal           = 0
    
    let transactions = List<Transaction>()
    
    convenience init(budgetName: String, budgetPeriodicity: String, budgetInitialAmount: Int, budgetTotal: Int, budgetStartDate: Date){
        self.init()
        self.budgetName             = budgetName
        self.budgetPeriodicity      = budgetPeriodicity
        self.budgetInitialAmount    = budgetInitialAmount
        self.budgetTotal            = budgetTotal
        self.budgetStartDate        = budgetStartDate
//        let transaction = Transaction(transactionDescription: transactionDescription, transactionAmount: transactionAmount)
//        transactions.append(transaction)
    }
    
    override static func primaryKey() -> String? {
           return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}
