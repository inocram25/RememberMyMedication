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
    @IBOutlet weak var appointmentDoctorHourLabel: UILabel!
    @IBOutlet weak var appointmentLocalLabel: UILabel!
    @IBOutlet weak var appointmentDayLabel: UILabel!
    @IBOutlet weak var appointmentMonthLabel: UILabel!
    @IBOutlet weak var borderedView: BorderedView!
    @IBOutlet weak var backView: UIView!

    var currentAppointment: Appointment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layer = backView.layer
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1
    }
    

    func configureCell(appointment: Appointment) {
        currentAppointment = appointment
        
        borderedView.backgroundColor = appointment.date.month?.color
        appointmentNameLabel.text = appointment.name
        
        let hour = appointment.date.hour
        let minute = appointment.date.minute
        appointmentDoctorHourLabel.text = appointment.doctor.isEmpty == false ? "Horário: \(hour):\(minute) / \(appointment.doctor)" : "Horário: \(hour):\(minute)"
        appointmentDayLabel.text = appointment.date.day.description
        appointmentMonthLabel.text = appointment.date.month?.description
        appointmentLocalLabel.text = appointment.local
        
    }
}
