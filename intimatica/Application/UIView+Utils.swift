//
//  UIView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/12/21.
//

import UIKit

extension UIView {
    func fillSuperview(withPadding constant:  CGFloat = 0)  {
        translatesAutoresizingMaskIntoConstraints = false
        guard  let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
        ])
    }
}
