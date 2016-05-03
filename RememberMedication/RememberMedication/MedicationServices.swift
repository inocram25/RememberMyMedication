//
//  DataServices.swift
//  CoreDataTests
//
//  Created by guilherme babugia on 29/04/16.
//  Copyright © 2016 guilherme babugia. All rights reserved.
//

import Foundation

class MedicationServices{
    
    static func createDataCD(medicationName:String, amount:NSInteger, takingEach:NSInteger, startTaking:NSDate){
        
        let data:MedicationCD = MedicationCD()
        
        data.medicationName = medicationName
        data.takingEach = takingEach
        data.startTaking = startTaking
        data.amount = amount
        
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
