//
//  MedicinesDetailsViewController.swift
//  RememberMedication
//
//  Created by guilherme babugia on 11/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

private enum MedicineDetailTable: String {
    case Name = "0,0"
    case Date = "1,0"
    case WeekDay = "1,1"
    case Dosage = "1,2"
    case Patient = "1,3"
    
    init?(indexPath: NSIndexPath) {
        let toString = "\(indexPath.section),\(indexPath.row)"
        if let option = MedicineDetailTable(rawValue: toString) {
            self = option
        } else {
            return nil
        }
    }
}

extension NSIndexPath {
    private var option: MedicineDetailTable? {
        return MedicineDetailTable(indexPath: self)
    }
}

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
            dosageLabel?.text = "Dosagem: \(medication.dosage)"
            patientLabel?.text = "Paciente: \(medication.patient)"
            borderedView?.backgroundColor = UIColor(red: CGFloat(medication.red), green: CGFloat(medication.green), blue: CGFloat(medication.blue), alpha: 1)
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if indexPath.option == .Name {
            return 98.0
        }
        if indexPath.option == .Date {
            return 60.0
        }
        if indexPath.option == .WeekDay {
            return 0.0
        }
        
        if indexPath.option == .Dosage && medication?.dosage != "0" {
            return 60.0
        }
        
        if indexPath.option == .Patient && medication?.patient.isEmpty == false {
            return 60.0
        }
        
        return 0.0
    }
}
