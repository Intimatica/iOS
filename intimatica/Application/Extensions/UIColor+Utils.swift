//
//  UIColorExtension.swift
//
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xFF) / 255,
            G: CGFloat((hex >> 08) & 0xFF) / 255,
            B: CGFloat((hex >> 00) & 0xFF) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    class var appDarkPurple: UIColor {
        UIColor(hex: 0x7633FF)
    }
    
    class  var appPurple: UIColor  {
        UIColor(hex: 0xE4D7FF)
    }
    
    class var appLightPurple: UIColor {
        UIColor(hex: 0xD0B9FF)
    }
    
    class var appPalePurple: UIColor {
        UIColor(hex: 0xE6DAFF)
    }
    
    class var appGrayPurple: UIColor {
        UIColor(hex: 0xF2ECFF)
    }
    
    class var appDarkGray: UIColor {
        UIColor(hex: 0x9A9A9A)
    }
    
    class var appGray: UIColor {
        UIColor(hex: 0xCCCCCC)
    }
    
    class var appLightGray: UIColor {
        UIColor(hex: 0xEAEAEA)
    }
    
    class var appYellow: UIColor {
        UIColor(hex: 0xFFE70D)
    }
    
    class var appRed: UIColor {
        UIColor(hex: 0xFF3333)
    }
    
    class var appBlue: UIColor {
        UIColor(hex: 0x4BD4FF)
    }
    
    class var appOrange: UIColor {
        UIColor(hex: 0xFFA217)
    }
    
    class var appGreen: UIColor {
        UIColor(hex: 0x64FFAA)
    }
    
    class var appPink: UIColor {
        UIColor(hex: 0xFF64DD)
    }
    
    class var appFuchsia: UIColor {
        UIColor(hex: 0xF9477D)
    }
}

