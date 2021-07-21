//
//  UIFont+Utils.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import UIKit

enum FontWeight: String {
    case regular = "Regular"
    case medium = "Medium"
    case light = "Light"
    case italic = "Italic"
    case bold = "Bold"
}

enum FontSize: CGFloat {
    case small = 12
    case regular = 18
    case title = 30
}

extension UIFont {
    static func rubik(fontSize: FontSize = .regular, fontWeight: FontWeight = .medium) -> UIFont {
        guard  let font = UIFont(name: "Rubik-\(fontWeight.rawValue)", size: fontSize.rawValue) else {
            // TODO: return before production
//            return UIFont.systemFont(ofSize: 17, weight: .regular)
            fatalError("Font Rubic-\(fontWeight.rawValue) size \(fontSize.rawValue) failed to init")
        }

        return font
    }
}
