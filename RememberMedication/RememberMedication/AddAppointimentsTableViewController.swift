//
//  AddAppointimentsTableViewController.swift
//  RememberMedication
//
//  Created by guilherme babugia on 04/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class AddAppointimentsTableViewController: UITableViewController {
    
    private var pickerVisible = false
    private var alarmPickerVisible = false
    private var dateAlarm = [[String]]()
    
    private var alarmDate = NSDate()
    private var appointmentDate = NSDate()
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var alarmLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var doctorTextfield: UITextField!
    @IBOutlet private weak var notesTextfield: UITextField!
    @IBOutlet private weak var localTextfield: UITextField!
    @IBOutlet private weak var alarmPickerView: UIPickerView!
    
    private var day = 0, hour = 0, min = 0
    
    //pensar em como configurar o local e o notes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmPickerView.dataSource = self
        alarmPickerView.delegate = self
        
        dateLabel.text = NSDate().toString
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        var hours = [String]()
        for i in 0...14 {
            hours.append(String(i) + " dias")
        }
        
        dateAlarm.append(hours)
        
        hours.removeAll()
        for i in 0...23 {
            hours.append(String(i) + " horas")
        }
        
        dateAlarm.append(hours)
        
        hours.removeAll()
        for i in 0...59 {
            hours.append(String(i) + " mins")
        }
        
        dateAlarm.append(hours)
        
        alarmLabel.text = ""
    }
    
    @IBAction func pickerDate(sender: UIDatePicker) {
        dateLabel.text = sender.date.toString
        appointmentDate = sender.date
    }
    
    
    @IBAction func saveButtonFunction(sender: AnyObject) {
        transformToDate()

        var name = ""
       
        if nameTextField.text != "" {
            name = nameTextField.text!
        }else{
            let alert = UIAlertController(title: "Error", message: "Digite o nome da Consulta", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        guard let date = dateLabel.text?.toDate else { return }
        let doctor = doctorTextfield.text?.isEmpty == false ? doctorTextfield.text : ""
        let local = localTextfield.text?.isEmpty == false ? localTextfield.text : ""
        let notes = notesTextfield.text?.isEmpty == false ? notesTextfield.text : ""
        
        let appointment = Appointment(name: name, date: date, doctor: doctor! , local: local!, notes: notes!)

        AppointmentServices.createDataCD(appointment)
        scheduleLocal(appointment)
        
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 && indexPath.section == 0 {
            pickerVisible = !pickerVisible
            tableView.reloadData()
        }
        if indexPath.row == 3 && indexPath.section == 0 {
            alarmPickerVisible = !alarmPickerVisible
            tableView.reloadData()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 2 && indexPath.section == 0 {
            return pickerVisible == false ? 0.0 : 165.0
        }
        
        if indexPath.row == 4 && indexPath.section == 0 {
            return alarmPickerVisible == false ? 0.0 : 165.0
        }
        
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func transformToDate(){
        
        let components = NSDateComponents()
        components.day = -day
        components.hour = -hour
        components.minute = -min
        alarmDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: appointmentDate, options: NSCalendarOptions.init(rawValue: 0))!
        
    }
    
    func scheduleLocal(appointment: Appointment) {
        let notification = UILocalNotification()
        notification.fireDate = alarmDate
        notification.alertBody = "Sua consulta é \(appointment.date) "
        notification.alertAction = "ver"
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}

extension AddAppointimentsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateAlarm[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dateAlarm[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            day = row
        }
        else if component == 1 {
            hour = row
        }
        else {
            min = row
        }
        
        transformToDate()
        
        var text = ""
        
        if day == 0 {
            if hour == 0 {
                if min != 0 {
                    text = "\(min) mins antes"
                }
            }
            else {
                if min != 0 {
                    text = "\(hour) hrs e \(min) mins antes"
                }
                else {
                    text = "\(hour) hrs antes"
                }
            }
        }
        else {
            if hour == 0 {
                if min != 0 {
                    text = "\(day) dias e \(min) mins antes"
                }
                else {
                    text = "\(day) dias antes"
                }
            }
            else {
                if min != 0 {
                    text = "\(day) dias, \(hour) hrs e \(min) mins antes"
                }
                else {
                    text = "\(day) dias e \(hour) hrs antes"
                }
            }
        }
        tableView.reloadData()
        alarmLabel.text = text
    }
}
