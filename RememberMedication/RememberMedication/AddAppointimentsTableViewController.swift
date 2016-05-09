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
    var alarmPickerVisible = false
    var dateAlarm = [[String]]()
    
    var alarmDate = NSDate()
    var appointmentDate = NSDate()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doctorTextfield: UITextField!
    @IBOutlet weak var notesTextfield: UITextField!
    @IBOutlet weak var localTextfield: UITextField!
    @IBOutlet weak var alarmPickerView: UIPickerView!
    
    var alarm = (day:"1 day", hour:"0 hours", min:"0 mins")
    var day = 0, hour = 0, min = 0
    
    //pensar em como configurar o local e o notes
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(alarm.day[alarm.day.startIndex])
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateLabel.text = dateFormatter.stringFromDate(NSDate())
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        var hours = [String]()
        for i in 0...14 {
            hours.append(String(i) + " days")
        }
        
        dateAlarm.append(hours)
        
        hours.removeAll()
        for i in 0...23 {
            hours.append(String(i) + " hours")
        }
        
        dateAlarm.append(hours)
        
        hours.removeAll()
        for i in 0...59 {
            hours.append(String(i) + " mins")
        }
        
        dateAlarm.append(hours)
        
        alarmPickerView.dataSource = self
        alarmPickerView.delegate = self
        
        alarmLabel.text = "1 day before."
        
    }
    
    @IBAction func pickerDate(sender: UIDatePicker) {
        dateLabel.text = dateFormatter.stringFromDate(sender.date)
        appointmentDate = sender.date
    }
    
    
    @IBAction func saveButtonFunction(sender: AnyObject) {
        transformToDate()
        
        guard nameTextField.text != "" else { return } //Colocar uma notificacao quando o usuario nao colocar o nome do remedio.
        let date = dateFormatter.dateFromString(dateLabel.text!)
        
        //FAZER CALCULO DO ALARM - DATE P/ ATRIBUIR NO ALARMDATE
        let appointment = Appointment(name: nameTextField.text!, date: date!, alarmDate: NSDate(), doctor: "dunha" , local: "na cada das prima", notes: "")

        AppointmentServices.createDataCD(appointment)
        
        print(alarmDate)
        scheduleLocal(alarmDate)
        
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
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    
    
    
    func transformToDate(){
        
        let components = NSDateComponents()
        components.day = -day
        components.hour = -hour
        components.minute = -min
        alarmDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: appointmentDate, options: NSCalendarOptions.init(rawValue: 0))!
        
        print("Calculo da data = \(alarmDate)")
        
    }
    
    func scheduleLocal(date: NSDate) {
        let notification = UILocalNotification()
        notification.fireDate = date
        notification.alertBody = "Hey you! Yeah you! Swipe to unlock!"
        notification.alertAction = "be awesome!"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
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
            alarm.day = dateAlarm[component][row]
            day = row
        }
        else if component == 1 {
            alarm.hour = dateAlarm[component][row]
            hour = row
        }
        else {
            alarm.min = dateAlarm[component][row]
            min = row
        }
        
        transformToDate()
        alarmLabel.text = alarm.day + ", " + alarm.hour + " and " + alarm.min + " before."
    }
    
    
    
}