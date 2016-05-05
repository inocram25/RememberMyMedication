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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(appointment: Appointment) {
        appointmentNameLabel.text = appointment.name
        
        //formatar data conforme necessario
//        appointmentDateLabel.text = date.description
        
    }
   

}
