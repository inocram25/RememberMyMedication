//
//  WeekDay.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 5/4/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation

struct WeekDay: OptionSetType {
    let rawValue: Int16
    
    init(rawValue: Int16) {
        self.rawValue = rawValue
    }

    static let Sunday       = WeekDay(rawValue: 1 << 0)
    static let Monday       = WeekDay(rawValue: 1 << 1)
    static let Tuesday      = WeekDay(rawValue: 1 << 2)
    static let Wednesday    = WeekDay(rawValue: 1 << 3)
    static let Thursday     = WeekDay(rawValue: 1 << 4)
    static let Friday       = WeekDay(rawValue: 1 << 5)
    static let Saturday     = WeekDay(rawValue: 1 << 6)
}
