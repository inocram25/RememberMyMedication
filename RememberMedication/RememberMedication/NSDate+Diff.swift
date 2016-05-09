//
//  NSDate+Diff.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 5/9/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation

extension NSDate {
    
    func difference(date: NSDate) -> Float {
        let calendar = NSCalendar.currentCalendar()
        let totalDays = calendar.components(NSCalendarUnit.Day, fromDate: self, toDate: date, options: NSCalendarOptions.MatchFirst)
        let completedDays = calendar.components(NSCalendarUnit.Day, fromDate: self, toDate: NSDate() , options: NSCalendarOptions.MatchFirst)
        return Float(completedDays.day) / Float (totalDays.day + 1)
    }
}