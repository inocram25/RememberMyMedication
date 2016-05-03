//
//  DataCD.swift
//  CoreDataTests
//
//  Created by guilherme babugia on 29/04/16.
//  Copyright © 2016 guilherme babugia. All rights reserved.
//

import Foundation
import CoreData

class MedicationCD: NSManagedObject {

    @NSManaged var medicationName: String
    @NSManaged var amount: NSInteger
    @NSManaged var takingEach: NSInteger
    @NSManaged var startTaking: NSDate
    
    /// The designated initializer
    convenience init()
    {
        // get context
        let context:NSManagedObjectContext = DatabaseManager.sharedInstance.managedObjectContext!
        
        // create entity description
        let entityDescription:NSEntityDescription? = NSEntityDescription.entityForName("MedicationCD", inManagedObjectContext: context)
        
        // call super using
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }

}
