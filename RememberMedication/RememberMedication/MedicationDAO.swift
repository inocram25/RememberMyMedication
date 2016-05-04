//
//  DataDAO.swift
//  CoreDataTests
//
//  Created by guilherme babugia on 29/04/16.
//  Copyright © 2016 guilherme babugia. All rights reserved.
//

import Foundation
import CoreData

class MedicationDAO{
    
    
    static func findByName(name: String) -> MedicationCD?
    {
        let request = NSFetchRequest(entityName: "MedicationCD")
        
        // assign predicate
        request.predicate = NSPredicate(format: "medicationName == %@", name)
        
        // perform search
        let results = (try! DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request)) as! [MedicationCD]
        return results.first
    }

    static func returnAll() -> [MedicationCD]?
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "MedicationCD")
        
        // perform search
        let results:[MedicationCD] = (try! DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request)) as! [MedicationCD]
        
        return results
    }
    
    static func insert(objectToBeInserted:MedicationCD)
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
        if error != nil
        {
            // log error
            print(error, terminator: "")
        }
    }
    
    static func delete(objectToBeDeleted:MedicationCD)
    {
        // remove object from context
        let error:NSErrorPointer = nil
        DatabaseManager.sharedInstance.managedObjectContext?.deleteObject(objectToBeDeleted)
        do {
            try DatabaseManager.sharedInstance.managedObjectContext?.save()
        } catch let error1 as NSError {
            error.memory = error1
        }
        
        if error != nil
        {
            print(error, terminator: "")
        }
    }


}
