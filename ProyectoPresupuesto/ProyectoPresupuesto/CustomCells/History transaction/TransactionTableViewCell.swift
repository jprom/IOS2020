//
//  TransactionTableViewCell.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 5/1/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    
    func setupCell(transaction: Transaction) {
        transactionNameLabel.text   = transaction.transactionDescription
        transactionAmountLabel.text = String(transaction.transactionAmount)
    }

    
}
