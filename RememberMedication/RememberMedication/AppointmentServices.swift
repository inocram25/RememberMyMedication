//
//  AppointmentServices.swift
//  RememberMedication
//
//  Created by guilherme babugia on 02/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation

class AppointmentServices{
    
    static func createDataCD(appointment: Appointment){
        
        let data:AppointmentCD = AppointmentCD()
        
        data.name = appointment.name
        data.doctor = appointment.doctor
        data.date = appointment.date
        data.notes = appointment.notes
        data.local = appointment.local
        
        AppointmentDAO.insert(data)
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
            
            let data:AppointmentCD? = AppointmentDAO.findByDate(date)
            if (data != nil)
            {
                // delete data
                AppointmentDAO.delete(data!)
            }
        })
        
        auxiliarQueue.addOperation(deleteOperation)
        
    }
}
