//
//  AddIncomeExpensesUIViewController.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/22/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit


protocol AddTransactionViewControllerProtocol: class {
    func addTransaction(transaction: Transaction)
}


class AddIncomeExpensesUIViewController: UIViewController {

    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var multiplier: Int = 1
    var transaction: Transaction?
    
    weak var delegate: AddTransactionViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Se inicaliza la clase")
    
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let amount: Int = Int(amountTextField.text!) ?? 0
        let newTransaction = Transaction(transactionDescription: descriptionTextView.text, transactionAmount: amount*multiplier)
        delegate?.addTransaction(transaction: newTransaction)
        print("New Transaction: \(newTransaction)")
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
   


}
