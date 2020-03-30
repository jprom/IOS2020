//
//  ProductListTableViewCell.swift
//  Tarea#3
//
//  Created by Juan Pablo Rosales on 3/27/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productQtyLabel: UILabel!
    
    @IBOutlet weak var productImageImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func setupCell(producto: Producto){
        productNameLabel.text = producto.name
        productQtyLabel.text = "Qty: "+String(producto.quantity)
        productImageImageView.image = UIImage(named: producto.image)
        dateLabel.text = producto.date.getFormatted(dateStyle: .short, timeStyle: .long)
        
    }
    
}
