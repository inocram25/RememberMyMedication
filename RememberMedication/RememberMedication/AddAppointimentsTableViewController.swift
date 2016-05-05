//
//  AddAppointimentsTableViewController.swift
//  RememberMedication
//
//  Created by guilherme babugia on 04/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class AddAppointimentsTableViewController: UITableViewController {

    let dateFormatter = NSDateFormatter()
    var pickerVisible = false
    var dateAlarm = [[String]]()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doctorTextfield: UITextField!
    @IBOutlet weak var notesTextfield: UITextField!
    @IBOutlet weak var localTextfield: UITextField!
    @IBOutlet weak var alarmPickerView: UIPickerView!
    
    //pensar em como configurar o local e o notes
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        dateLabel.text = dateFormatter.stringFromDate(NSDate())
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        var hours = [String]()
        for i in 1...14 {
            hours.append(String(i) + "days")
        }
        
        dateAlarm.append(hours)
        
        hours.removeAll()
        for i in 0...23 {
            hours.append(String(i) + "hours")
        }
        
        dateAlarm.append(hours)
        
        hours.removeAll()
        for i in 0...59 {
            hours.append(String(i) + "mins")
        }
        
        dateAlarm.append(hours)
        
        alarmPickerView.dataSource = self
        alarmPickerView.delegate = self
        
    }
    
    @IBAction func pickerDate(sender: UIDatePicker) {
        dateLabel.text = dateFormatter.stringFromDate(sender.date)
    }
    @IBAction func saveButtonFunction(sender: AnyObject) {
        
        guard nameTextField.text != nil else { return }
        let date = dateFormatter.dateFromString(dateLabel.text!)
//        let medication = Medication(name: nameTextField.text!, amount: 1, takingEach: 1, startTaking: date!)
//        MedicationServices.createDataCD(medication)
        
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 && indexPath.section == 0 {
            pickerVisible = !pickerVisible
            tableView.reloadData()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 2 && indexPath.section == 0 {
            return pickerVisible == false ? 0.0 : 165.0
        }
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44.0
    }

    

}

extension AddAppointimentsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateAlarm.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dateAlarm[component][row]
    }
}