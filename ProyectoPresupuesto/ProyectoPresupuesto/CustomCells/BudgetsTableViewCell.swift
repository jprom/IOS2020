//
//  BudgetsTableViewCell.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/19/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit

class BudgetsTableViewCell: UITableViewCell {

    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var amountTotalTextLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateInitLabel: UILabel!
    
    func setupCell(budget: Budget) {
        //let subtotal = getSubtotal(budget: budget)
        budgetNameLabel.text        = budget.budgetName
        amountTotalTextLabel.text   = "Total:"
        dateInitLabel.text          = "\(budget.budgetStartDate)"
        //amountLabel.text            = "₡ \(subtotal)"
        amountLabel.text            = "₡ \(budget.budgetTotal)"
    }
    
    func getSubtotal(budget: Budget) -> Int{
        var total = 0
        for transaction in budget.transactions {
            total += transaction.transactionAmount
            print("monto de la transaccion: \(transaction.transactionAmount)")
        }
        return total
    }
}
