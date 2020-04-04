//
//  RealmManager.swift
//  Tarea#3
//
//  Created by Juan Pablo Rosales on 4/3/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import Foundation
import RealmSwift

/*
 maneja las operaciones y queries de la base de datos
 */

class RealmManager {
    //paso 0 - obtenemos la instancia de Realm
    
    //paso 1 creamos el objeto
    var myProduct = Producto()
    
    func insertProduct(name: String, quantity: Int, image: String){
        let producto = Producto(name: name, quantity: quantity, image: image)
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(producto, update: .all)
            }
        } catch {
                print("Realm fallo por alguna razon")
        }
                    
    }
    
    
    //metodo sincrono
    func getAllProducts() -> Results<Producto>? {
        let realm = try? Realm()
        return realm?.objects(Producto.self)
    }
    
    //completionHandler puede ser cualquier nombre
    func getAllProducts(completionHandler:(_ productos: Results<Producto>?) -> Void){
        completionHandler(getAllProducts())
    }
    
    //remove
    func removeProduct(product: Producto){
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(product)
            }
        } catch {
            print("Fallo el borrado del producto")
        }
    }

}
