//
//  BudgetListViewController.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/16/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit
import RealmSwift

class BudgetListViewController: UIViewController {

    @IBOutlet weak var myNextButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var budgets: Results<Budget>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate      = self
        tableView.dataSource    = self
        addBudgetNavigationButton()
        registerCustomCell()
        createBudgets()
        title = "Presupuestos"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
   
    
    func addBudgetNavigationButton() {
        let addNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBudgetAction(sender:)))
        navigationItem.rightBarButtonItem = addNavigationButton
    }
    
    //Top right button action
    @objc func addBudgetAction(sender: UIBarButtonItem) {
        if let budgetUIViewController = storyboard?.instantiateViewController(identifier: "BudgetUIViewController") as? BudgetUIViewController {
            navigationController?.pushViewController(budgetUIViewController, animated: true)
        }
    }
    
    //Register Custom cell
    func registerCustomCell() {
        let nib = UINib(nibName: "BudgetsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BudgetsTableViewCell")
    }
    
    //Load Budgets From DB
    func createBudgets() {
        let realmManager = BudgetRealmManager()
        let budgets = realmManager.getAllBudgets()
        print("\(budgets)")
        self.budgets = budgets
        tableView.reloadData()
        
    }
}



//Extension TableView
extension BudgetListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetsTableViewCell")  as? BudgetsTableViewCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "NO EXISTE"
            return cell
        }
        cell.accessoryType = .disclosureIndicator
        
        if let budget = budgets?[indexPath.row] {
            //cell background
            if budget.budgetTotal <= 0{
                cell.backgroundColor = UIColor.red
            }
            
            if budget.budgetTotal > 0{
                cell.backgroundColor = UIColor.green
            }
            
            cell.setupCell(budget: budget)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let displayBudgetViewController = storyboard?.instantiateViewController(identifier: "DisplayBudgetViewController") as? DisplayBudgetViewController, let budget = budgets?[indexPath.row] {
            displayBudgetViewController.budget      = budget
            navigationController?.pushViewController(displayBudgetViewController, animated: true)
        }
    }
    
    //Swipe actions
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    //Confirmation window
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //delete
        let refreshAlert = UIAlertController(title: "Confirmacion", message: "El presupuesto sera eliminado", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Start delete")
            if editingStyle == .delete {
                if let budget = self.budgets?[indexPath.row] {
                    let realmManager = BudgetRealmManager()
                    realmManager.removeBudget(budget: budget)
    
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.endUpdates()
                }
            }
            print("End Delete")
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    //end condirmation window

    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let updateAction = UIContextualAction(style: .destructive, title: "Update") { (action, view, handler) in
            print("Add Action Tapped")
            if let budgetUIViewController = self.storyboard?.instantiateViewController(identifier: "BudgetUIViewController") as? BudgetUIViewController  {
                if let budget = self.budgets?[indexPath.row] {
                        budgetUIViewController.budget = budget
                    self.navigationController?.pushViewController(budgetUIViewController, animated: true)
                }
            }
        }
        updateAction.backgroundColor = .green
        let configuration = UISwipeActionsConfiguration(actions: [updateAction])
        return configuration
    }
    
}
