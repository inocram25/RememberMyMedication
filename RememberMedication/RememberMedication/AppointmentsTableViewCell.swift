//
//  AppointimentsTableViewCell.swift
//  RememberMedication
//
//  Created by guilherme babugia on 04/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class AppointmentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var appointmentNameLabel: UILabel!
    @IBOutlet weak var appointmentDateLabel: UILabel!
    @IBOutlet weak var appointmentDoctorLabel: UILabel!
    @IBOutlet weak var appointmentLocalLabel: UILabel!
    
    let dateFormatter = NSDateFormatter()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(appointment: Appointment) {
        appointmentNameLabel.text = appointment.name

        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        appointmentDateLabel.text = dateFormatter.stringFromDate(appointment.date)
        appointmentDoctorLabel.text = appointment.doctor
        appointmentLocalLabel.text = appointment.local
    }
}
