//
//  DataCD.swift
//  CoreDataTests
//
//  Created by guilherme babugia on 29/04/16.
//  Copyright © 2016 guilherme babugia. All rights reserved.
//

import Foundation
import CoreData

public final class MedicationCD: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var amount: Int64
    @NSManaged var takingEach: Int64
    @NSManaged var startTaking: NSDate
    @NSManaged private var primitiveWeekDay: NSNumber
    
    private static let WeekDayKey = "weekDay"
    var weekDay: WeekDay {
        get {
            willAccessValueForKey(MedicationCD.WeekDayKey)
            let val = WeekDay(rawValue: primitiveWeekDay.shortValue)
            didAccessValueForKey(MedicationCD.WeekDayKey)
            return val
        }
        set {
            willChangeValueForKey(MedicationCD.WeekDayKey)
            primitiveWeekDay = NSNumber(short: newValue.rawValue)
            didChangeValueForKey(MedicationCD.WeekDayKey)
        }
    }
    
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
