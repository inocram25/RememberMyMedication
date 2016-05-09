//
//  AppointmentCD.swift
//  RememberMedication
//
//  Created by guilherme babugia on 02/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation
import CoreData

class AppointmentCD: NSManagedObject {
    
    @NSManaged var notes: String
    @NSManaged var name: String
    @NSManaged var local: String
    @NSManaged var date: NSDate
    @NSManaged var doctor: String
    
    /// The designated initializer
    convenience init()
    {
        // get context
        let context:NSManagedObjectContext = DatabaseManager.sharedInstance.managedObjectContext!
        
        // create entity description
        let entityDescription:NSEntityDescription? = NSEntityDescription.entityForName("AppointmentCD", inManagedObjectContext: context)
        
        // call super using
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }
    
}
