//
//  UIColor+Ink.swift
//  Inkster
//
//  Created by andre on 10/20/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func healthU_Orange() -> Self {
        return self.init(red: 233.0 / 255.0, green: 88.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)
    }
    
    class func healthU_LightGrey() -> Self {
        return self.init(red: 239.0 / 255.0, green: 239.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
    }
    

    class func randomColor() -> Self {
        let randomRed:CGFloat = CGFloat.random()
        let randomGreen:CGFloat = CGFloat.random()
        let randomBlue:CGFloat = CGFloat.random()
        
        return self.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
