//
//  UIColor+Extension.swift
//  TheForkTest
//
//  Created by SIFFRE on 01/10/2016.
//  Copyright © 2016 Siffrej. All rights reserved.
//

import UIKit

extension UIColor {
    
    /* PRIMARY COLOURS */
    
    class func TFMainGreen() -> UIColor {
        return self.init(colorLiteralRed: 88/255, green: 148/255, blue: 66/255, alpha: 1)
    }
    
    class func TFGrayBg() -> UIColor {
        return self.init(colorLiteralRed: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    }
    
    class func TFGreenBg() -> UIColor {
        return self.init(colorLiteralRed: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    }
    
    /* TEXT COLORS */
    
    class func TFGrayText() -> UIColor {
        return self.init(colorLiteralRed: 152/255, green: 152/255, blue: 152/255, alpha: 1)
    }
    
    class func TFTitle() -> UIColor {
        return self.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1)
    }
}
