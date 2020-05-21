//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Changhyun Baek on 2020/05/21.
//  Copyright © 2020 paikwiki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNameField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    var item: Item!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formmater = DateFormatter()
        formmater.dateStyle = .medium
        formmater.timeStyle = .none
        return formmater
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNameField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }
}
