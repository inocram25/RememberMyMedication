//
//  AppointmentServices.swift
//  RememberMedication
//
//  Created by guilherme babugia on 02/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation

struct Appointment {
    let name: String
    let date: NSDate
    let doctor: String
    let local: String
    let notes: String
    
    var hour: Int {
        return getComponentForUnit(.Hour)
    }
    var minute: Int {
        return getComponentForUnit(.Minute)
    }
    var day: Int {
        return getComponentForUnit(.Day)
    }
    var month: Month? {
        return Month(rawValue: getComponentForUnit(.Month))
    }
    
    func getComponentForUnit(unit: NSCalendarUnit) -> Int {
        return NSCalendar.currentCalendar().component(unit, fromDate: date)
    }
}

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
