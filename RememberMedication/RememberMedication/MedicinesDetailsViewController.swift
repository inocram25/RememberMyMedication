//
//  MedicinesDetailsViewController.swift
//  RememberMedication
//
//  Created by guilherme babugia on 11/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class MedicinesDetailsViewController: UITableViewController {

    var medication: Medication?
    
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var timeLabel: UILabel?
    @IBOutlet private weak var endDateLabel: UILabel?
    @IBOutlet private weak var weekDayLabel: UILabel?
    @IBOutlet private weak var dosageLabel: UILabel?
    @IBOutlet private weak var patientLabel: UILabel?
    @IBOutlet private weak var borderedView: BorderedView?
    @IBOutlet private var backViews: [UIView]?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let medication = medication, endMonth = medication.endDate.month {
            nameLabel?.text = medication.name
            timeLabel?.text = "\(medication.startDate.hour):\(medication.startDate.minute)"
            endDateLabel?.text = "Termino: \(medication.endDate.day) de \(endMonth.description.lowercaseString)"
            dosageLabel?.text = medication.dosage
            patientLabel?.text = medication.patient
            borderedView?.backgroundColor = medication.startDate.month?.color
//            weekDayLabel?.text = medication.weekDay
        }
        
        backViews?.forEach { view in
            let layer = view.layer
            layer.shadowColor = UIColor.blackColor().CGColor
            layer.shadowOffset = CGSize(width: 0, height: 0.5)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = 1
        }
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
}
