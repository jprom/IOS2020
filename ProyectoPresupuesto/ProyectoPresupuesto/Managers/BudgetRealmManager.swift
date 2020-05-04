//
//  BudgetRealmManager.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/16/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import Foundation
import RealmSwift

class BudgetRealmManager {
    
    
    //Select
    //Obtiene todas las categorias de forma syncrona
    func getAllBudgets() -> Results<Budget>? {
        let realm = try? Realm()
        return realm?.objects(Budget.self)
    }

    //Obtiene todas las categorias de forma asyncrona
    func getAllBudgets(completionHandler:(_ budgets: Results<Budget>?) -> Void) {
        completionHandler(getAllBudgets())
    }
    
    //Insert
    func insertBudget(budgetName: String, budgetPeriodicity: String, budgetInitialAmount: Int, budgetTotal: Int, budgetStartDate: Date, transactionDescription: String, transactionAmount: Int) {
        let budget = Budget(budgetName: budgetName, budgetPeriodicity: budgetPeriodicity, budgetInitialAmount: budgetInitialAmount, budgetTotal: budgetTotal, budgetStartDate: budgetStartDate)
        do {
            let transaction = Transaction(transactionDescription: transactionDescription, transactionAmount: transactionAmount)
            let realm = try Realm()
            try realm.write {
                realm.add(budget, update: .all)
                budget.transactions.append(transaction)//agrega transaction al budget creado
            }
        } catch {
            print("Realm falló por alguna razón")
        }
    }
    
    //Delete
    func removeBudget(budget: Budget) {
        do {
            //let realm = try! Realm() esto es incorrecto xq esta haciendo un forze unwrap, si por alguna razon es nulo, la aplicación se va a caer
            let realm = try Realm()
            try realm.write {
                realm.delete(budget)
            }
        } catch {
            print("Realm falló por alguna razón")
        }
    }
    
    //Updates
    func updateTotal(budgetID: String, total: Int) {
       
        do {
            let realm = try Realm()

            try realm.write {
                for budget in realm.objects(Budget.self).filter("id == %@", budgetID) {
                    budget.budgetTotal = total
                }
            }
        } catch {
            print("Realm falló por alguna razón")
        }
    }
    
    func updateBudgetName(budgetID: String, name: String) {
       
        do {
            let realm = try Realm()

            try realm.write {
                for budget in realm.objects(Budget.self).filter("id == %@", budgetID) {
                    budget.budgetName = name
                }
            }
        } catch {
            print("Realm falló por alguna razón")
        }
    }
    
    //Transactions
    func addTransactionToBudget(transaction: Transaction, budget: Budget) {
        do {
            let realm = try Realm()
            try realm.write {
                budget.transactions.append(transaction)
            }
        } catch {
            print("Realm falló por alguna razón")
        }
    }
    
    
    func removeTransaction(transaction: Transaction) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(transaction)
            }
        } catch {
            print("Realm falló por alguna razón")
        }
    }
    
    
    //Clear Everything
    func clearAllData(){
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Realm falló por alguna razón")
        }
    }
}
