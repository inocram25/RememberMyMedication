//
//  DataServices.swift
//  CoreDataTests
//
//  Created by guilherme babugia on 29/04/16.
//  Copyright © 2016 guilherme babugia. All rights reserved.
//

import Foundation

class MedicationServices {
    
    static func createDataCD(medication: Medication) {
        
        let m = MedicationCD()
        m.name = medication.name
        m.dosage = medication.dosage
        m.patient = medication.patient
        m.interval = medication.interval
        m.startDate = medication.startDate
        m.endDate = medication.endDate
        m.weekDay = medication.weekDay
        m.id = medication.id
        m.red = medication.red
        m.green = medication.green
        m.blue = medication.blue
        
        MedicationDAO.insert(m)
    }
    
    static func deleteByName(name: String){
        
        let auxiliarQueue:NSOperationQueue = NSOperationQueue()
        
        let deleteOperation : NSBlockOperation = NSBlockOperation(block: {
           
            let data:MedicationCD? = MedicationDAO.findByName(name)
            
            
            if (data != nil)
            {
                MedicationDAO.delete(data!)
            }
        })
        
        auxiliarQueue.addOperation(deleteOperation)

    }
}
