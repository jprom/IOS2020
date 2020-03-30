//
//  Articulo.swift
//  Tarea#3
//
//  Created by Juan Pablo Rosales on 3/27/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import Foundation

struct Producto {
    
    var identifier =  NSUUID().uuidString
    var name: String
    var quantity: String
    var image: String
    var date = Date()
    
}
