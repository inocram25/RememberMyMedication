//
//  AppointimentsTableViewCell.swift
//  RememberMedication
//
//  Created by guilherme babugia on 04/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class AppointimentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var appointimentNameLabel: UILabel!
    
    @IBOutlet weak var appointimentDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(appointiment: String, date: NSDate) {
        appointimentNameLabel.text = appointiment
        
        //formatar data conforme necessario
        appointimentDateLabel.text = date.description
        
    }
   

}
