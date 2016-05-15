//
//  NSDate+Diff.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 5/9/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation

extension NSDate {
    
    var toString: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return dateFormatter.stringFromDate(self)
    }
    
    var hour: String {
        return "\(getComponentForUnit(.Hour))"
    }
    var minute: String {
        return getComponentForUnit(.Minute) > 10 ? "\(getComponentForUnit(.Minute))" : "0\(getComponentForUnit(.Minute))"
    }
    var day: Int {
        return getComponentForUnit(.Day)
    }
    var month: Month? {
        return Month(rawValue: getComponentForUnit(.Month))
    }
    
    func getComponentForUnit(unit: NSCalendarUnit) -> Int {
        return NSCalendar.currentCalendar().component(unit, fromDate: self)
    }
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        return self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
    }
    
    var dayOfWeek: Int? {
        let comp = NSCalendar.currentCalendar().components(.Weekday, fromDate: self)
        return  1 << (comp.weekday - 1)
    }
}
