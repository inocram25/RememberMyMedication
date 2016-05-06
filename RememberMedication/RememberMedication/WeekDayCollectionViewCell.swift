//
//  WeekDayCollectionViewCell.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 5/6/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

@IBDesignable class WeekDayCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var weekDayLabel: UILabel!
    
    @IBInspectable internal var borderRadius: Float {
        get {
            return Float(layer.cornerRadius)
        }
        set {
            layer.masksToBounds = newValue > 0
            layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable internal var borderWidth: Float {
        get {
            return Float(layer.borderWidth)
        }
        set {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable internal var borderColor: UIColor {
        get {
            guard let color = layer.borderColor else {
                return UIColor(CGColor: UIColor.clearColor().CGColor)
            }
            return UIColor(CGColor: color)
        }
        set {
            layer.borderColor = newValue.CGColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        borderRadius = Float(self.frame.size.width / 2)
    }
    
    func configureCell(weekDay: String) {
        weekDayLabel.text = weekDay
    }
}
