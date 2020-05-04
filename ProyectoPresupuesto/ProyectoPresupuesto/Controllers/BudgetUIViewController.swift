//
//  BudgetUIViewController.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/13/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit
import RealmSwift



class BudgetUIViewController: UIViewController {

    //Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var periodPicker: UIPickerView!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var initialAmountTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    //Variables
    var nameText            = ""
    var periodText          = "Semanal"
    var dateValue:Date      = Date()
    var initialAmountValue  = "0"
    var totalAcumulated     = 0
    let pickerData          = ["Semanal", "Quincenal", "Mensual"]
    var budget: Budget?
    var editMode: Bool = false
    
    //Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateDatePicker.datePickerMode = .date
        //datasource and delegate
        
        //period picker
        periodPicker.delegate           = self
        periodPicker.dataSource         = self
        //textfields
        nameTextField.delegate          = self
        initialAmountTextField.delegate = self
        
        if let budget = budget {
            nameTextField.text = budget.budgetName
            dateDatePicker.isUserInteractionEnabled = false
            periodPicker.isUserInteractionEnabled = false
            initialAmountTextField.text = String(budget.budgetInitialAmount)
            initialAmountTextField.isUserInteractionEnabled = false
            editMode = true
            title = "Editar Presupuesto"
        } else {
            title = "Nuevo Presupuesto"
            //addSaveNavigationButton()
        }
    }//End ViewDidLoad
    
    
    //Actions
    //Save Button action
    @IBAction func getBudgetValuesAction(_ sender: Any) {
        self.view.endEditing(true)
        totalAcumulated = Int(initialAmountValue)!
        
        //guardamos
        let amount:Int? = Int(initialAmountValue)
        let realmManager = BudgetRealmManager()
        if editMode == true{
            realmManager.updateBudgetName(budgetID: budget!.id, name: nameText)
        }else{
                realmManager.insertBudget(budgetName: nameText, budgetPeriodicity: periodText, budgetInitialAmount: amount!, budgetTotal: totalAcumulated, budgetStartDate: dateValue, transactionDescription: "Monto Inicial", transactionAmount: Int(initialAmountValue)!)
                //realmManager.addTransactionToBudget
                print("se guardo")
        }
        
        
        
        //let budgets = realmManager.getAllBudgets()
        
        //Return to Previous Interface
        navigationController?.popViewController(animated: true)
        
    }
    
        
    //Date picker action
    
    @IBAction func datePickerChangedAction(_ sender: Any) {
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        dateValue =  dateDatePicker.date
        
    }
    

}


//Picker handler Extension
extension BudgetUIViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerData[row]
    }
    //Selected Picker Value Handler
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        periodText = pickerData[row]
        //saveButton.setTitle(periodText, for: .normal)
    }
}//End Picker Handler Extension

//Textfields handler extension
extension BudgetUIViewController: UITextFieldDelegate{
    
    //Close keyboard with return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        initialAmountTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameText            = nameTextField.text!
        initialAmountValue  = initialAmountTextField.text!
    }
    
    
}
