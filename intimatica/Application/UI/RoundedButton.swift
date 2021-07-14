//
//  RoundedButton.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

class UIRoundedButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if layer.cornerRadius != bounds.height / 2 {
            layer.cornerRadius = bounds.height / 2
        }
    }
    
}
