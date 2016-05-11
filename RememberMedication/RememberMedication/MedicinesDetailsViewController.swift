//
//  MedicinesDetailsViewController.swift
//  RememberMedication
//
//  Created by guilherme babugia on 11/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class MedicinesDetailsViewController: UITableViewController {

    var medication: Medication!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Medication = \(medication.name)")
    }
    
    

}
