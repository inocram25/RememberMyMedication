//
//  AddMedicineTableViewController.swift
//  RememberMedication
//
//  Created by Leonardo Maffei on 03/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

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
        guard nameTextfield.text != "" else { return } //Colocar uma notificacao quando o usuario nao colocar o nome do remedio.
        let date = dateFormatter.dateFromString(dateLabel.text!)
        let medication = Medication(name: nameTextfield.text!, dosage: "100", patient: "maffei", timesDay: 3, startDate: date!, endDate: NSDate(), weekDay: WeekDay.Friday)
        MedicationServices.createDataCD(medication)
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 && indexPath.section == 1 {
            startDatePickerVisible = !startDatePickerVisible
            tableView.reloadData()
        }
        if indexPath.row == 2 && indexPath.section == 1 {
            endDatePickerVisible = !endDatePickerVisible
            tableView.reloadData()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 1 && indexPath.section == 1 {
            return startDatePickerVisible == false ? 0.0 : 165.0
        }
        if indexPath.row == 3 && indexPath.section == 1 {
            return endDatePickerVisible == false ? 0.0 : 165.0
        }
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44.0
    }
    
}
