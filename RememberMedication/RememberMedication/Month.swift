//
//  Month.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 5/11/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation
import UIKit

enum Month: Int {
    case January = 1
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case December
    
}

extension Month: CustomStringConvertible {
    var description: String {
        switch self {
        case .January:
            return "JAN"
        case .February:
            return "FEV"
        case .March:
            return "MAR"
        case .April:
            return "ABR"
        case .May:
            return "MAI"
        case .June:
            return "JUN"
        case .July:
            return "JUL"
        case .August:
            return "AGO"
        case .September:
            return "SET"
        case .October:
            return "OUT"
        case .November:
            return "NOV"
        case .December:
            return "DEZ"
            
        }
    }
    
    var color: UIColor {
        switch self {
        case .January:
            return UIColor.blueColor()
        case .February:
            return UIColor.lightGrayColor()
        case .March:
            return UIColor.grayColor()
        case .April:
            return UIColor.redColor()
        case .May:
            return UIColor.blackColor()
        case .June:
            return UIColor.magentaColor()
        case .July:
            return UIColor.cyanColor()
        case .August:
            return UIColor.brownColor()
        case .September:
            return UIColor.purpleColor()
        case .October:
            return UIColor.greenColor()
        case .November:
            return UIColor.orangeColor()
        case .December:
            return UIColor.yellowColor()
            
        }
    }
}