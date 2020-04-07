//
//  ItemsViewController.swift
//  QuizRealm
//
//  Created by Juan Pablo Rosales on 4/7/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit
import RealmSwift

class ItemsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    let itemTableViewCellIdentifier = "itemInventoryCustomCell"
    var itemsList: Results<Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCustomCell()
        createItems()
        // Do any additional setup after loading the view.
    }
    
    //1- Registrar la celda custom
    func registerCustomCell() {
        let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: itemTableViewCellIdentifier)
    }
    
    func createItems() {
        let realmManager = RealmManager()
        itemsList = realmManager.getAllItems()
        if let items = itemsList, items.isEmpty {
            realmManager.insertItem(tagNumber: 1, name: "Mancuernas 1Kg", quantity: 2)
            realmManager.insertItem(tagNumber: 2, name: "Mancuernas 2.5Kg", quantity: 2)
            realmManager.insertItem(tagNumber: 3, name: "Mancuernas 5Kg", quantity: 2)
            realmManager.insertItem(tagNumber: 4, name: "Mancuernas 7.5Kg", quantity: 2)
            realmManager.insertItem(tagNumber: 5, name: "Pesa Rusa 2.5Kg", quantity: 2)
            realmManager.insertItem(tagNumber: 6, name: "Pesa Rusa 5Kg", quantity: 2)
            realmManager.insertItem(tagNumber: 7, name: "Pesa Rusa 7.5Kg", quantity: 2)
            realmManager.insertItem(tagNumber: 8, name: "Pesa Rusa 10Kg", quantity: 2)
            realmManager.insertItem(tagNumber: 9, name: "Banda Elastica M", quantity: 2)
            realmManager.insertItem(tagNumber: 10, name: "Bosu Chest", quantity: 2)
            print("SE INSERTARON LOS ITEMS")
            createItems()
        } else {
            
            tableView.reloadData()
        }
    }
}


extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemInventoryCustomCell")  as? ItemTableViewCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "NO EXISTE"
            return cell
        }
        if let item = itemsList?[indexPath.row] {
            cell.setupCell(item: item)
        }
        return cell
    }
}
