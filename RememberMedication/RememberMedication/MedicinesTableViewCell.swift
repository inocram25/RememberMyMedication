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
    
    var currentMedication: Medication?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(medication: Medication) {
        currentMedication = medication
        
        borderedView.backgroundColor = medication.startDate.month?.color
        progressView.tintColor = medication.startDate.month?.color
        medicineNameLabel.text = medication.name
        patient.text = medication.patient
        timeLabel.text = "\(medication.startDate.hour):\(medication.startDate.minute)"
        
        let calendar = NSCalendar.currentCalendar()
        let totalDays = calendar.components(NSCalendarUnit.Day, fromDate: medication.startDate, toDate: medication.endDate, options: NSCalendarOptions.MatchFirst)
        let completedDays = calendar.components(NSCalendarUnit.Day, fromDate: medication.startDate, toDate: NSDate() , options: NSCalendarOptions.MatchFirst)
        let diff = Float(completedDays.day) / Float (totalDays.day + 1)
        progressView.setProgress(diff, animated: true)
        
        let remainingDays = totalDays.day - completedDays.day
        dosageLabel.text = "Dosagem: \(medication.dosage)mg / \(remainingDays) Restantes"
    }
}
