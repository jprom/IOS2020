//
//  ItemTableViewCell.swift
//  QuizRealm
//
//  Created by Juan Pablo Rosales on 4/7/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var tagNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    
    
    
    func setupCell(item: Item){
        tagNumberLabel.text = String("Tag Number: \(item.tagNumber)")
        nameLabel.text = String("Nombre: \(item.name)")
        quantityLabel.text = String("Qty: \(item.quantity)")
        purchaseDateLabel.text = String("Fecha Compra: \(item.purchaseDate.getFormatted(dateStyle: .short, timeStyle: .long))")
        
    }
}
