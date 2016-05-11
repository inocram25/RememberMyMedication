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
    case Frequency = "1,4"
    case WeekDay = "1,5"
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
    var weekDayVisible = false
    
    var weekDay = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"]
    var weekDaySelected: WeekDay?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var dosageTextField: UITextField!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var pacientTextField: UITextField!
    @IBOutlet weak var weekDayCollectionView: UICollectionView!
    @IBOutlet weak var frequencySwitch: UISwitch!
    @IBOutlet weak var intervalLabel: UILabel!
    
    let dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .MediumStyle
        dateLabel.text = dateFormatter.stringFromDate(NSDate())
        
        endDateLabel.text = ""
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        weekDayCollectionView.delegate = self
        weekDayCollectionView.dataSource = self
    }
    
    @IBAction func pickerDate(sender: UIDatePicker) {
        dateLabel.text = dateFormatter.stringFromDate(sender.date)
    }
    @IBAction func pickerEndDate(sender: UIDatePicker) {
        endDateLabel.text = dateFormatter.stringFromDate(sender.date)
    }
    @IBAction func saveButtonFunction(sender: AnyObject) {
        
        var name = ""
        
        if nameTextfield.text != "" {
            name = nameTextfield.text!
        }else{
            let alert = UIAlertController(title: "Error", message: "Digite o nome do Remedio", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        guard let startDate = dateFormatter.dateFromString(dateLabel.text!) else { return }
        let endDate = endDateLabel.text?.isEmpty == false ? dateFormatter.dateFromString(endDateLabel.text!) : NSDate()
        let dosage = dosageTextField.text?.isEmpty == false ? dosageTextField.text : "0"
        let pacient = pacientTextField.text?.isEmpty == false ? pacientTextField.text : ""
        let days:WeekDay?

        if weekDaySelected == nil {
            days = [.Sunday, .Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday]
        } else {
            days = weekDaySelected
        }
        
        let medication = Medication(name: name,
                                    dosage: dosage!,
                                    patient: pacient!,
                                    interval: 1,
                                    startDate: startDate,
                                    endDate: endDate!,
                                    weekDay: days!,
                                    id: NSUUID().UUIDString)
        
        MedicationServices.createDataCD(medication)
        scheduleLocal(medication)
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scheduleLocal(medication: Medication) {
        print("add notification for - \(medication)")
        let notification = UILocalNotification()
        notification.fireDate = medication.startDate
        notification.alertBody = "Hora de tomar remedio!"
        notification.alertAction = "be awesome!"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["ID": medication.id]
        if medication.startDate.difference(medication.endDate) > 0 {
            notification.repeatInterval = .Day
            
        }
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    @IBAction func switchAction(sender: UISwitch) {
        tableView.reloadData()
    }
    
    //Tableview
    
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
        if indexPath.option == .WeekDay {
            return frequencySwitch.on ? 75.0 : 0.0
        }
        
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44.0
    }
    
}

extension AddMedicineTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDay.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "WeekDayCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as? WeekDayCollectionViewCell
        print(weekDay[indexPath.row])
        cell?.configureCell(weekDay[indexPath.row])
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as? WeekDayCollectionViewCell
        guard let cellValue = cell!.weekdayValue else { return }
        
        if weekDaySelected?.contains(cellValue) == true {
            weekDaySelected?.remove(cellValue)
            cell?.backgroundColor = UIColor.lightGrayColor()
        }else {
            if let day = weekDaySelected {
                weekDaySelected = [day, cellValue]
            } else {
                weekDaySelected = cellValue
            }
            cell?.backgroundColor = UIColor.healthU_Orange()
        }
    }
}
