//
//  UILabel+Utils.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/18/21.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont, textColor: UIColor = .black, text: String? = nil) {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        self.font = font
        self.textColor = textColor
        self.text = text
    }
}
