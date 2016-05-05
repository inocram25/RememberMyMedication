//
//  AppointmentDAO.swift
//  RememberMedication
//
//  Created by guilherme babugia on 02/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation
import CoreData

class AppointmentDAO{
    
    
    //    static func findByName(name: String) -> MedicationCD?
    //    {
    //        // creating fetch request
    //        let request = NSFetchRequest(entityName: "MedicationCD")
    //
    //        // assign predicate
    //        request.predicate = NSPredicate(format: "medicationName == %@", name)
    //
    //        // perform search
    //        let results:[MedicationCD] = (try! DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request)) as! [MedicationCD]
    //
    //        return results[0]
    //    }
    
    static func findByDate(date: NSDate) -> AppointmentCD?
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "MedicationCD")
        
        // assign predicate
        request.predicate = NSPredicate(format: "date == %@", date)
        
        // perform search
        let results:[AppointmentCD] = (try! DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request)) as! [AppointmentCD]
        
        return results[0]
    }
    
    static func returnAll() -> [AppointmentCD]?
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "AppointimentCD")
        
        // assign predicate
        //        request.predicate = NSPredicate(format: "medicationName == %@", name)
        
        // perform search
        let results:[AppointmentCD] = (try! DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request)) as! [AppointmentCD]
        
        return results
    }
    
    
    
    static func insert(objectToBeInserted:AppointmentCD)
    {
        print("entrou no insert")
        // insert element into context
        DatabaseManager.sharedInstance.managedObjectContext?.insertObject(objectToBeInserted)
        
        // save context
        let error:NSErrorPointer = nil
        do {
            try DatabaseManager.sharedInstance.managedObjectContext?.save()
        } catch let error1 as NSError {
            error.memory = error1
        }
        if (error != nil)
        {
            // log error
            print(error, terminator: "")
        }
    }
    
    static func delete(objectToBeDeleted:AppointmentCD)
    {
        // remove object from context
        let error:NSErrorPointer = nil
        DatabaseManager.sharedInstance.managedObjectContext?.deleteObject(objectToBeDeleted)
        do {
            try DatabaseManager.sharedInstance.managedObjectContext?.save()
        } catch let error1 as NSError {
            error.memory = error1
        }
        
        // log error
        if (error != nil)
        {
            // log error
            print(error, terminator: "")
        }
    }
    
    
}
