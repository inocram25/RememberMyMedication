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
    case Interval = "1,6"
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
    
    private var startDatePickerVisible = false
    private var endDatePickerVisible = false
    private var weekDayVisible = false
    
    private var weekDay = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"]
    private var weekDaySelected: WeekDay?
    private var interval = 0
    private var index = 0
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var dosageTextField: UITextField!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var pacientTextField: UITextField!
    @IBOutlet weak var weekDayCollectionView: UICollectionView!
    @IBOutlet weak var frequencySwitch: UISwitch!
    @IBOutlet weak var sliderInterval: UISlider!
    @IBOutlet weak var intervalTimeLabel: UILabel!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    
    var intervals = [1,2,3,4,6,8,12,24]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = NSDate().toString
        endDateLabel.text = ""
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        weekDayCollectionView.delegate = self
        weekDayCollectionView.dataSource = self
        
        //limitando os datepickers
        startDatePicker.minimumDate = NSDate()
        endDatePicker.minimumDate = NSDate()
        endDatePicker.maximumDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 6, toDate: NSDate(), options: [])
    }
    
    @IBAction func pickerDate(sender: UIDatePicker) {
        dateLabel.text = sender.date.toString
    }
    @IBAction func pickerEndDate(sender: UIDatePicker) {
        endDateLabel.text = sender.date.toString
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
        
        guard let startDate = dateLabel.text!.toDate else { return }
        let endDate = endDateLabel.text?.isEmpty == false ? endDateLabel.text!.toDate : NSDate()
        let dosage = dosageTextField.text?.isEmpty == false ? dosageTextField.text : "0"
        let pacient = pacientTextField.text?.isEmpty == false ? pacientTextField.text : ""
        let i = interval == 24 ? 0 : interval
        
        let days = weekDaySelected == nil ? [.Sunday, .Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday] : weekDaySelected
        
        let medication = Medication(name: name,
                                    dosage: dosage!,
                                    patient: pacient!,
                                    interval: Int64(i),
                                    startDate: startDate,
                                    endDate: endDate!,
                                    weekDay: days!,
                                    id: NSUUID().UUIDString)
        
        MedicationServices.createDataCD(medication)
        // Chamar Notificacao
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func switchAction(sender: UISwitch) {
        tableView.reloadData()
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let indexAux = Int(sender.value)
        //?????????
        sliderInterval?.setValue(Float(indexAux), animated: false)
        interval = intervals[indexAux]
        if index != indexAux {
            index = indexAux
        }
        intervalTimeLabel.text = "\(interval) horas"
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
        
        if indexPath.option == .Interval {
            return 70.0
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
