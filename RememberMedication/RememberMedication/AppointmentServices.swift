//
//  AppointmentServices.swift
//  RememberMedication
//
//  Created by guilherme babugia on 02/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation

class AppointimentServices{
    
    static func createDataCD(appointimentType:String, date:NSDate, local:String, notes:String){
        
        let data:AppointimentCD = AppointimentCD()
        
        data.appointimentType = appointimentType
        data.date = date
        data.local = local
        data.notes = notes
        
        AppointimentDAO.insert(data)
    }
    
//    static func deleteByName(name: String){
//        
//        let auxiliarQueue:NSOperationQueue = NSOperationQueue()
//        
//        let deleteOperation : NSBlockOperation = NSBlockOperation(block: {
//            
//            let data:AppointimentCD? = AppointimentDAO.findByDate(name)
//            if (data != nil)
//            {
//                // delete data
//                AppointimentDAO.delete(data!)
//            }
//        })
//        
//        auxiliarQueue.addOperation(deleteOperation)
//        
//    }
    
    static func deleteByDate(date: NSDate){
        
        let auxiliarQueue:NSOperationQueue = NSOperationQueue()
        
        let deleteOperation : NSBlockOperation = NSBlockOperation(block: {
            
            let data:AppointimentCD? = AppointimentDAO.findByDate(date)
            if (data != nil)
            {
                // delete data
                AppointimentDAO.delete(data!)
            }
        })
        
        auxiliarQueue.addOperation(deleteOperation)
        
    }
}
