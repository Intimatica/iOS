//
//  UIButton+Utils.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/22/21.
//

import UIKit

extension UIButton {
    convenience init(title: String, titleColor: UIColor, font: UIFont, backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
        setBackgroundColor(backgroundColor, for: .normal)
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(colorImage, for: state)
    }
}
