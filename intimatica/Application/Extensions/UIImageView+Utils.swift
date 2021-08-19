//
//  UIImageView+Utils.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/19/21.
//

import UIKit

extension UIImageView {
    convenience init(name: String, contentMode: UIView.ContentMode) {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: name)
        self.contentMode = contentMode
    }
}
