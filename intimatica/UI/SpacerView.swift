//
//  SpacerView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/30/21.
//

import UIKit

final class SpacerView: UIView {
    
    // MARK: - Initializers
    init(height: CGFloat, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
