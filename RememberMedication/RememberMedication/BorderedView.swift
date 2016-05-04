//
//  RoundedView.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 5/4/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

@IBDesignable public class BorderedView: UIView {
    
    @IBInspectable public var borderRadius: Float {
        get {
            return Float(layer.cornerRadius)
        }
        set {
            layer.masksToBounds = newValue > 0
            layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable public var borderWidth: Float {
        get {
            return Float(layer.borderWidth)
        }
        set {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
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
}
