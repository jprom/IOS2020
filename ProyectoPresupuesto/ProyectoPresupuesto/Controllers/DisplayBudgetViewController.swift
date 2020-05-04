//
//  DisplayBudgetViewController.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/24/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import SwiftDate

class DisplayBudgetViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var addMoneyButton: UIButton!
    @IBOutlet weak var addExpensesButton: UIButton!
    var budget: Budget?
    let subTotal: Int = 0
    let realmManager = BudgetRealmManager()
    let currentDateTime = Date()//.getFormatted(dateStyle: .short, timeStyle: .long)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
        
        getTimePeriod()
        
    }
    
    func setValues(){
        nameLabel.text          = budget!.budgetName
        totalAmountLabel.text   = String(budget!.budgetTotal)
    }
    
    func getTimePeriod(){
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)

    }
    
   
    @objc func fire()
    {
        let finalDate = getFinalDate(initialDate: budget!.budgetStartDate, period: budget!.budgetPeriodicity)
        let customDate1 = Date()

        let difference = getSecondsBetween(start: customDate1, end: finalDate)
        print("difference \(difference)")
        let formatString = formatTimer(seconds: difference)
        print(formatString)
        timeLeftLabel.text = formatString
    }
    
    func getSecondsBetween(start: Date, end: Date) -> Int {
        let result = end.timeIntervalSince(start)
        return Int(result)
    }

    func formatTimer(seconds: Int) -> String {
        let hours           = Int(seconds) / 3600
        let minutes         = Int(seconds) / 60 % 60
        let seconds         = Int(seconds) % 60
        var timeLeftString  = ""
        if hours > 23 {
            let numberOfDays: Int = hours / 24
            if numberOfDays == 1{
                timeLeftString = "\(numberOfDays) Dia"
            }else{
                timeLeftString = "\(numberOfDays) Dias"
            }
            
        }else{
            timeLeftString = "\(hours) Hrs, \(minutes) Min, \(seconds) Sec"
        }
        return timeLeftString
    }
    
    func getFinalDate(initialDate: Date, period: String) -> Date{
        var finalDate = Date()
        switch period {
        case "Semanal":
            finalDate = initialDate + 7.days
        break
        case "Quincenal":
            finalDate = initialDate + 15.days
        break
        case "Mensual":
            finalDate = initialDate + 1.months
        break
        default:
            finalDate = initialDate + 7.days
        }
        
        return finalDate
    }
    
    @IBAction func addMoneyAction(_ sender: Any) {
        
        performSegue(withIdentifier: "addMoneySegue", sender: self)
        
    }
    
    @IBAction func addExpensesAction(_ sender: Any) {
        performSegue(withIdentifier: "addExpenseSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMoneySegue"{
                if let destination = segue.destination as? AddIncomeExpensesUIViewController{
                    destination.delegate = self
                    destination.multiplier = 1
                }
        }else if segue.identifier == "addExpenseSegue"{
            if let destination = segue.destination as? AddIncomeExpensesUIViewController{
                destination.delegate = self
                destination.multiplier = -1
            }
        }
    }
}


extension DisplayBudgetViewController: AddTransactionViewControllerProtocol {
    func addTransaction(transaction: Transaction) {
        if let budget = budget {
            realmManager.addTransactionToBudget(transaction: transaction, budget: budget)
            navigationController?.popViewController(animated: true)
        }
        
        var total = 0
        for transaction in budget!.transactions {
            total += transaction.transactionAmount
        }
        realmManager.updateTotal(budgetID: budget!.id, total: total)
        print ("\(budget)")
        
    }
    
    
    
}
