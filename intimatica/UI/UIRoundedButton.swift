//
//  RoundedButton.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

class UIRoundedButton: UIButton {
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if layer.cornerRadius != bounds.height / 3 {
            layer.cornerRadius = bounds.height / 3
        }
    }
    
}
