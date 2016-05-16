//
//  Medication.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 5/11/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation

struct Medication {
    let name: String
    let dosage: String
    let patient: String
    let interval: Int64
    let startDate: NSDate
    let endDate: NSDate
    let weekDay: WeekDay
    let id: String
    let red: Float
    let green: Float
    let blue: Float
}
