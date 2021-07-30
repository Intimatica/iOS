//
//  UILabel+Utils.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/31/21.
//

import UIKit

extension UILabel {
    func setAttributedText(withString string: String, boldString: String, font: UIFont) {
        let attributedString = NSMutableAttributedString(string: string,
                                                     attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        attributedText = attributedString
    }
}
