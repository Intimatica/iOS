//
//  UIStackView+Utils.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/31/21.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { subView in
            removeArrangedSubview(subView)
            NSLayoutConstraint.deactivate(subView.constraints)
            subView.removeFromSuperview()
        }
    }
}
