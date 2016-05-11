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

    
    var currentAppointment: Appointment?

    func configureCell(appointment: Appointment) {
        currentAppointment = appointment
        
        appointmentNameLabel.text = appointment.name
     
        let hour = appointment.date.hour
        let minute = appointment.date.minute
        appointmentDoctorHourLabel.text = appointment.doctor.isEmpty == false ? "Horário: \(hour):\(minute) / \(appointment.doctor)" : "Horário: \(hour):\(minute)"
        appointmentDayLabel.text = appointment.date.day.description
        appointmentMonthLabel.text = appointment.date.month?.description
        appointmentLocalLabel.text = appointment.local
        
    }
}
