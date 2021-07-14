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
    
    class var appPurple: UIColor {
        UIColor(hex: 0x7633FF)
    }
    
    class var appYellow: UIColor {
        UIColor(hex: 0xFFDC24)
    }
}

