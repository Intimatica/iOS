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
    
    var lineSpacing: CGFloat {
        get { return 0 }
        set {
            let textAlignment = self.textAlignment
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = newValue
            let attributedString = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            self.attributedText = attributedString
            self.textAlignment = textAlignment
        }
    }
}
