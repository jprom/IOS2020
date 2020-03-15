//
//  ViewController.swift
//  TareaTabla
//
//  Created by pablo rosales on 3/14/20.
//  Copyright © 2020 pablo rosales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let maxValue = 100
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        
        if ((indexPath.row+1)%2==0) {
            cell.backgroundColor = UIColor.red
            cell.textLabel?.text = "\(indexPath.row+1) - Par"
        }else{
            cell.backgroundColor = UIColor.systemBlue
            cell.textLabel?.text = "\(indexPath.row+1) - Impar"
        }
        
        return cell
    }
}

