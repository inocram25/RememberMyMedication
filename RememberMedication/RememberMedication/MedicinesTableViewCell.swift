//
//  MedicinesTableViewCell.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 4/29/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class MedicinesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var medicineNameLabel: UILabel?
    @IBOutlet private weak var dosageLabel: UILabel?
    @IBOutlet private weak var progressView: UIProgressView?
    @IBOutlet private weak var borderedView: BorderedView?
    @IBOutlet private weak var patient: UILabel?
    @IBOutlet private weak var timeLabel: UILabel?
    @IBOutlet private weak var backView: UIView?
    
    var currentMedication: Medication?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layer = backView?.layer
        layer?.shadowColor = UIColor.blackColor().CGColor
        layer?.shadowOffset = CGSize(width: 0, height: 0.5)
        layer?.shadowOpacity = 0.4
        layer?.shadowRadius = 1
    }
    
    func configureCell(medication: Medication) {
        currentMedication = medication
        let medicineColor = UIColor(red: CGFloat(medication.red), green: CGFloat(medication.green), blue: CGFloat(medication.blue), alpha: 1)
        
        borderedView?.backgroundColor = medicineColor
        progressView?.progressTintColor = medicineColor
        medicineNameLabel?.text = medication.name
        patient?.text = medication.patient
        timeLabel?.text = "\(medication.startDate.hour):\(medication.startDate.minute)"
        
        let calendar = NSCalendar.currentCalendar()
        let totalDays = calendar.components(NSCalendarUnit.Day, fromDate: medication.startDate, toDate: medication.endDate, options: NSCalendarOptions.MatchFirst)
        let completedDays = calendar.components(NSCalendarUnit.Day, fromDate: medication.startDate, toDate: NSDate() , options: NSCalendarOptions.MatchFirst)
        let diff = Float(completedDays.day) / Float (totalDays.day + 1)
        progressView?.setProgress(diff, animated: true)
        
        var remainingDays = totalDays.day - completedDays.day
        if remainingDays < 0 {
            remainingDays = 0
        }
        dosageLabel?.text = "Dosagem: \(medication.dosage)mg / \(remainingDays) Dias restantes"
    }
}
