//
//  CloseButton.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/30/21.
//

import UIKit

final class CloseButton: UIButton {
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setBackgroundImage(UIImage(named: "back_button_icon"), for: .normal)
    }
}
