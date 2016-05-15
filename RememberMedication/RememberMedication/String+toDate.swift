//
//  String+toDate.swift
//  RememberMedication
//
//  Created by Alexandre Marconi on 15/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//
import Foundation

extension String {
    var toDate:NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return dateFormatter.dateFromString(self)
    }
}
