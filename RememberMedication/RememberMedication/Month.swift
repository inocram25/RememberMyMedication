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
            return UIColor(red: 249.0 / 255.0, green: 181.0 / 255.0, blue: 178.0 / 255.0, alpha: 1.0)
        case .February:
            return UIColor(red: 234.0 / 255.0, green: 148.0 / 255.0, blue: 215.0 / 255.0, alpha: 1.0)
        case .March:
            return UIColor(red: 243.0 / 255.0, green: 110.0 / 255.0, blue: 75.0 / 255.0, alpha: 1.0)
        case .April:
            return UIColor(red: 246.0 / 255.0, green: 148.0 / 255.0, blue: 49.0 / 255.0, alpha: 1.0)
        case .May:
            return UIColor(red: 241.0 / 255.0, green: 221.0 / 255.0, blue: 64.0 / 255.0, alpha: 1.0)
        case .June:
            return UIColor(red: 198.0 / 255.0, green: 199.0 / 255.0, blue: 82.0 / 255.0, alpha: 1.0)
        case .July:
            return UIColor(red: 177.0 / 255.0, green: 204.0 / 255.0, blue: 159.0 / 255.0, alpha: 1.0)
        case .August:
            return UIColor(red: 165.0 / 255.0, green: 218.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
        case .September:
            return UIColor(red: 165.0 / 255.0, green: 188.0 / 255.0, blue: 218.0 / 255.0, alpha: 1.0)
        case .October:
            return UIColor(red: 162.0 / 255.0, green: 161.0 / 255.0, blue: 143.0 / 255.0, alpha: 1.0)
        case .November:
            return UIColor(red: 200.0 / 255.0, green: 179.0 / 255.0, blue: 132.0 / 255.0, alpha: 1.0)
        case .December:
            return UIColor(red: 152.0 / 255.0, green: 135.0 / 255.0, blue: 98.0 / 255.0, alpha: 1.0)
        }
    }
}