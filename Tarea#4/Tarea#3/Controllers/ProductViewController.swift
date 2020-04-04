//
//  ProductViewController.swift
//  Tarea#3
//
//  Created by Juan Pablo Rosales on 3/27/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit

protocol productViewControllerProtocol: class {
    func addProducto(producto: Producto)
}

class ProductViewController: UITableViewController {
    
    var producto: Producto? //es opcional
    
    @IBOutlet weak var nameProductTextView: UITextField!
    
    @IBOutlet weak var quantityProductTextView: UITextField!
    
    @IBOutlet weak var dateProductDatePicker: UIDatePicker!
    
    weak var delegate: productViewControllerProtocol?
    
    let imageArray = ["Product1", "Product2", "Product3", "Product4", "Product5"]
    
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        saveProductNavigationButton()
      
    }

    //Agregamos un boton de save
    func saveProductNavigationButton(){
        let addNavigationButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveProductAction(sender:)))
        navigationItem .rightBarButtonItem = addNavigationButton
    }
    
    //logica al tocar el add button, me envia a la siguiente vista
    @objc  func saveProductAction(sender: UIBarButtonItem){
        
        if let productName = nameProductTextView.text {
        
            let producto = Producto(name:  productName, quantity: Int(quantityProductTextView.text!)!, image: imageArray.randomElement()!)        
            //Definir el protocolo
            delegate?.addProducto(producto: producto)
            realmManager.insertProduct(name: producto.name, quantity: producto.quantity, image: producto.image)
            
        }else{
            //presenta el error
            let alertController = UIAlertController(title: "Error", message: "Debe llenar todos los campos", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        
    }

}
