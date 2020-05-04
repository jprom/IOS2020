//
//  ConfigViewController.swift
//  ProyectoPresupuesto
//
//  Created by Juan Pablo Rosales on 4/17/20.
//  Copyright © 2020 Juan Pablo Rosales. All rights reserved.
//

import UIKit
import RealmSwift

class ConfigViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let version = releaseVersionNumber
        let release = buildVersionNumber
        versionLabel.text   = "App Version: \(version ?? "")"
        buildLabel.text     = "Build: \(release ?? "")"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    var releaseVersionNumber: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    
    @IBAction func clearAllData(_ sender: Any) {
        
        
        //delete
            let refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                //start clear data
                let realmManager = BudgetRealmManager()
                realmManager.clearAllData()
                //end clear data
            }))

            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))

            present(refreshAlert, animated: true, completion: nil)
        
        
    }
    
}
