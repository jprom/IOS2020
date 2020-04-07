//
//  RealmManager.swift
//  QuizRealm
//
//  Created by Juan Pablo Rosales on 4/4/20.
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
    func insertItem(tagNumber: Int, name: String, quantity: Int){
        let item = Item(tagNumber: tagNumber, name: name, quantity: quantity)
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(item, update: .all)
            }
        } catch {
                print("Realm fallo por alguna razon")
        }
                    
    }
    

    //metodo sincrono
    func getAllItems() -> Results<Item>? {
        let realm = try? Realm()
        return realm?.objects(Item.self)
    }
    
    //completionHandler puede ser cualquier nombre
    func getAllItems(completionHandler:(_ items: Results<Item>?) -> Void){
        completionHandler(getAllItems())
    }
    
    //remove
    func removeProduct(item: Item){
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Fallo el borrado del producto")
        }
    }

}
