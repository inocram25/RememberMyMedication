//
//  DataServices.swift
//  CoreDataTests
//
//  Created by guilherme babugia on 29/04/16.
//  Copyright © 2016 guilherme babugia. All rights reserved.
//

import Foundation

struct Medication {
    let name: String
    let amount: NSInteger
    let takingEach: NSInteger
    let startTaking: NSDate
}

class MedicationServices {
    
    static func createDataCD(medicaiton: Medication) {
        
        let data:MedicationCD = MedicationCD()
        data.medicationName = medicaiton.name
        data.takingEach = medicaiton.takingEach
        data.startTaking = medicaiton.startTaking
        data.amount = medicaiton.amount
        
        MedicationDAO.insert(data)
    }
    
    static func deleteByName(name: String){
        
        let auxiliarQueue:NSOperationQueue = NSOperationQueue()
        
        let deleteOperation : NSBlockOperation = NSBlockOperation(block: {
           
            let data:MedicationCD? = MedicationDAO.findByName(name)
            if (data != nil)
            {
                // delete data
                MedicationDAO.delete(data!)
            }
        })
        
        auxiliarQueue.addOperation(deleteOperation)

    }
}
