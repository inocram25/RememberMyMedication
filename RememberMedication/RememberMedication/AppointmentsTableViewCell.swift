//
//  AppointimentsTableViewCell.swift
//  RememberMedication
//
//  Created by guilherme babugia on 04/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

enum Month: Int {
    case January = 1
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case December
    
}

extension Month: CustomStringConvertible {
    var description: String {
        switch self {
        case .January:
            return "JAN"
        case .February:
            return "FEV"
        case .March:
            return "MAR"
        case .April:
            return "ABR"
        case .May:
            return "MAI"
        case .June:
            return "JUN"
        case .July:
            return "JUL"
        case .August:
            return "AGO"
        case .September:
            return "SET"
        case .October:
            return "OUT"
        case .November:
            return "NOV"
        case .December:
            return "DEZ"

        }
    }
}

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
        
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: appointment.date)
        let minute = NSCalendar.currentCalendar().component(.Minute, fromDate: appointment.date)
        let day = NSCalendar.currentCalendar().component(.Day, fromDate: appointment.date)
        let month = NSCalendar.currentCalendar().component(.Month, fromDate: appointment.date)
        
     
        appointmentDoctorHourLabel.text = appointment.doctor.isEmpty == false ? "Horário: \(hour):\(minute) / \(appointment.doctor)" : "Horário: \(hour):\(minute)"
        appointmentDayLabel.text = "\(day)"
        appointmentMonthLabel.text = Month.init(rawValue: month)?.description
        appointmentLocalLabel.text = appointment.local
        
    }
}
