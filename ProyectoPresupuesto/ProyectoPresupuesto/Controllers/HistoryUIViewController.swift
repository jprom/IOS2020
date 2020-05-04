//
//  HistoryUIViewController.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/17/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryUIViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    var budgets: Results<Budget>?
    var budget: Budget?
//    var presupuestos = [Budget]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate   = self
        historyTableView.dataSource = self
        registerCustomCell()
        createBudgets()
        title = "Historial"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createBudgets()
        historyTableView.reloadData()
    }

   
}





extension HistoryUIViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return budgets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets?[section].transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell")  as? TransactionTableViewCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "NO EXISTE"
            return cell
        }
        cell.accessoryType = .none
        if let transaction = budgets?[indexPath.section].transactions[indexPath.row] {
           cell.setupCell(transaction: transaction)
        }
        return cell
    }
    
    //Register Custom cell
    func registerCustomCell() {
        let nibTitle = UINib(nibName: "TitleHistoryTransactionsTableViewCell", bundle: nil)
        historyTableView.register(nibTitle, forHeaderFooterViewReuseIdentifier: "TitleHistoryTransactionsTableViewCell")
        
        let nib = UINib(nibName: "TransactionTableViewCell", bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: "TransactionTableViewCell")
    }
    
    //Load Budgets From DB
    func createBudgets() {
        let realmManager = BudgetRealmManager()
        print("Creando los budgets")
        let budgets = realmManager.getAllBudgets()
        self.budgets = budgets
        historyTableView.reloadData()
        
    }
    
    //METODOS NECESARIOS PARA EL HEADER
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65.0
    }
    
    //Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TitleHistoryTransactionsTableViewCell") as? TitleHistoryTransactionsTableViewCell else {
            return UIView()
        }
        self.budget = budgets![section]
        cell.setupCell(budget: budget!)
        return cell
    }
    
    //Swipe actions
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       return true
   }
   
   //Confirmation window
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       //delete
       let refreshAlert = UIAlertController(title: "Confirmar", message: "Realmente desea eliminar la transaccion?", preferredStyle: UIAlertController.Style.alert)

       refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
           print("Start delete")
           if editingStyle == .delete {
            
                
            
            
              // if let budget = self.budgets?[indexPath.row] { //originsl
            if let budget = self.budgets?[indexPath.section] {
                let amountToRemove = budget.transactions[indexPath.row].transactionAmount
                let newTotalAmount = (budget.budgetTotal - amountToRemove)
                    let realmManager = BudgetRealmManager()
                    realmManager.removeTransaction(transaction: budget.transactions[indexPath.row])
                    realmManager.updateTotal(budgetID: budget.id, total: newTotalAmount)
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.reloadSections([indexPath.section], with: .fade)
                    tableView.endUpdates()
               }
           }
           print("End Delete")
       }))

       refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
             print("Handle Cancel Logic here")
       }))

       present(refreshAlert, animated: true, completion: nil)
   }
   
   //end condirmation window
}
