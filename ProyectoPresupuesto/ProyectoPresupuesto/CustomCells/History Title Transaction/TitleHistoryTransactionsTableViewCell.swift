//
//  TitleHistoryTransactionsTableViewCell.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 5/1/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit
import RealmSwift

class TitleHistoryTransactionsTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    func setupCell(budget: Budget) {
        titleLabel.text   = budget.budgetName
        totalLabel.text = String(budget.budgetTotal)
    }
   
    
}
