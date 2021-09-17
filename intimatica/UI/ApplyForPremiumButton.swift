//
//  ApplyForPremiumButton.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/10/21.
//

import UIKit

class ApplyForPremiumButton: UIRoundedButton {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitle(L10n("APPLY_FOR_A_PREMIUM_BUTTON_TITLE"), for: .normal)
        setTitleColor(.init(hex: 0xFFE70D), for: .normal)
        setBackgroundColor(.appDarkPurple, for: .normal)
        setImage(UIImage(named: "star"), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 10, left: -20, bottom: 10, right: 0)
        
        titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .bold)
    }
}
