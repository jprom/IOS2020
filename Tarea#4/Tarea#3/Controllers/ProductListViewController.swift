//
//  ProductListViewController.swift
//  Tarea#3
//
//  Created by Juan Pablo Rosales on 3/27/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit
import RealmSwift

class ProductListViewController: UIViewController {
    @IBOutlet weak var productTableView: UITableView!
    var listaProductos : Results<Producto>?
    let productCellIdentifier = "ProductListTableViewCell" //crear identificador
    var productoCelda : Producto?
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        productTableView.delegate = self
        productTableView.dataSource = self
        registerCustomCell()
        addProductNavigationButton()
    }
    
    //paso 2: registrar la celda custom
    func registerCustomCell(){
        let nib = UINib(nibName: productCellIdentifier, bundle: nil)
        productTableView.register(nib, forCellReuseIdentifier: productCellIdentifier)
    }
    
    //Agregamos el boton de + para agregar un producto
    func addProductNavigationButton(){
        let addNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProductAction(sender:)))
        navigationItem .rightBarButtonItem = addNavigationButton
    }
    
    //logica al tocar el add button, me envia a la siguiente vista
    @objc  func addProductAction(sender: UIBarButtonItem){
        if let productViewController = storyboard?.instantiateViewController(identifier: "ProductViewController") as? ProductViewController{
            productViewController.delegate = self
            navigationController?.pushViewController(productViewController, animated: true)
        }
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ productTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //obtiene los productos ordenados por fecha
        listaProductos = realmManager.getAllProducts()!.sorted(byKeyPath: "date", ascending: false)
        print("la cantidad de productos es: \(listaProductos!.count)")
        return listaProductos!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: productCellIdentifier) as? ProductListTableViewCell else {
            return UITableViewCell()
        }
        
        let orderedProductList = listaProductos
        cell.setupCell(producto: orderedProductList![indexPath.row])
        return cell
    }
    
    //delete action
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let prod = listaProductos?[indexPath.row]{
                realmManager.removeProduct(product: prod)
                //listaProductos.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
            
        }
    }
    
    
    
   
}


//extension para el protocolo
extension ProductListViewController: productViewControllerProtocol{
       
    func addProducto(producto: Producto) {
        //listaProductos.append(producto)
        
        navigationController?.popViewController(animated: true)
        productTableView.reloadData()
        
    }
    
    
}
