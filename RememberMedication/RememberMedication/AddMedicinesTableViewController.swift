//
//  AddMedicineTableViewController.swift
//  RememberMedication
//
//  Created by Leonardo Maffei on 03/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

private enum AddMedicineTable: String {
    case Name = "0,0"
    case Dosage = "0,1"
    case StartDate = "1,0"
    case StartDatePicker = "1,1"
    case EndDate = "1,2"
    case EndDatePicker = "1,3"
    case Pacient = "2,0"
    
    init?(indexPath: NSIndexPath) {
        let toString = "\(indexPath.section),\(indexPath.row)"
        if let option = AddMedicineTable(rawValue: toString) {
            self = option
        } else {
            return nil
        }
    }
}

extension NSIndexPath {
    private var option: AddMedicineTable? {
        return AddMedicineTable(indexPath: self)
    }
}

class AddMedicineTableViewController: UITableViewController {
    
    var startDatePickerVisible = false
    var endDatePickerVisible = false
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var dosageTextField: UITextField!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var pacientTextField: UITextField!
    
    let dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .MediumStyle
        dateLabel.text = dateFormatter.stringFromDate(NSDate())
        
        endDateLabel.text = ""
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    @IBAction func pickerDate(sender: UIDatePicker) {
        dateLabel.text = dateFormatter.stringFromDate(sender.date)
    }
    @IBAction func pickerEndDate(sender: UIDatePicker) {
        endDateLabel.text = dateFormatter.stringFromDate(sender.date)
    }
    @IBAction func saveButtonFunction(sender: AnyObject) {
        guard let name = nameTextfield.text else { return }
        guard let startDate = dateFormatter.dateFromString(dateLabel.text!) else { return }
        let endDate = endDateLabel.text?.isEmpty == false ? dateFormatter.dateFromString(endDateLabel.text!) : NSDate()
        let dosage = dosageTextField.text?.isEmpty == false ? dosageTextField.text : "0"
        let pacient = pacientTextField.text?.isEmpty == false ? pacientTextField.text : ""
        let medication = Medication(name: name,
                                    dosage: dosage!,
                                    patient: pacient!,
                                    timesDay: 1,
                                    startDate: startDate,
                                    endDate: endDate!,
                                    weekDay: WeekDay.Friday)
        MedicationServices.createDataCD(medication)
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.option == .StartDate {
            startDatePickerVisible = !startDatePickerVisible
            tableView.reloadData()
        }
        
        if indexPath.option == .EndDate {
            endDatePickerVisible = !endDatePickerVisible
            tableView.reloadData()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.option == .StartDatePicker {
            return startDatePickerVisible == false ? 0.0 : 165.0
        }
        if indexPath.option == .EndDatePicker {
            return endDatePickerVisible == false ? 0.0 : 165.0
        }
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44.0
    }
    
}
