//
//  MedicinesTableViewCell.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 4/29/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class MedicinesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var medicineNameLabel: UILabel!
    @IBOutlet weak var dosageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var borderedView: BorderedView!
    @IBOutlet weak var patient: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressView.tintColor = UIColor.purpleColor()
        borderedView.backgroundColor = UIColor.purpleColor()
        borderedView.borderColor = UIColor.purpleColor()
    }
    
    func configureCell(medication: Medication) {
        print(medication)
        medicineNameLabel.text = medication.name
        patient.text = medication.patient
        
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: medication.startDate)
        let minute = NSCalendar.currentCalendar().component(.Minute, fromDate: medication.startDate)
        let hours = hour > 10 ? "\(hour)" : "0\(hour)"
        let minutes = minute > 10 ? "\(minute)" : "0\(minute)"
        
        timeLabel.text = "\(hours):\(minutes)"
        
        let calendar = NSCalendar.currentCalendar()
        let totalDays = calendar.components(NSCalendarUnit.Day, fromDate: medication.startDate, toDate: medication.endDate, options: NSCalendarOptions.MatchFirst)
        let completedDays = calendar.components(NSCalendarUnit.Day, fromDate: medication.startDate, toDate: NSDate() , options: NSCalendarOptions.MatchFirst)
        let diff = Float(completedDays.day) / Float (totalDays.day + 1)
        progressView.setProgress(diff, animated: true)
        
        let remainingDays = totalDays.day - completedDays.day
        dosageLabel.text = "Dosagem: \(medication.dosage)mg / \(remainingDays) Restantes"
    }
}
