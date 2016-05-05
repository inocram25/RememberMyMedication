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
    let amount: Int64
    let takingEach: Int64
    let startTaking: NSDate
    let weekDay: WeekDay
}

class MedicationServices {
    
    static func createDataCD(medication: Medication) {
        
        let m = MedicationCD()
        m.name = medication.name
        m.takingEach = medication.takingEach
        m.startTaking = medication.startTaking
        m.amount = medication.amount
        m.weekDay = medication.weekDay
        
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
