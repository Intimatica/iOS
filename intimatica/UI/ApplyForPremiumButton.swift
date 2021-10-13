//
//  ApplyForPremiumButton.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/10/21.
//

import UIKit

class ApplyForPremiumButton: UIRoundedButton {
    enum Design {
        case purle
        case yellow
    }
    
    // MARK: - Initializers
    init(desing: Design, fontSize: FontSize = .regular) {
        super.init(frame: .zero)
        
        setupUI(with: desing, fontSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(with desing: Design, fontSize: FontSize) {
        translatesAutoresizingMaskIntoConstraints = false
        
        switch desing {
        case .purle:
            setTitleColor(.appYellow, for: .normal)
            setBackgroundColor(.appDarkPurple, for: .normal)
            setImage(UIImage(named: "star_yellow"), for: .normal)
        case .yellow:
            setTitleColor(.black, for: .normal)
            setBackgroundColor(.appYellow, for: .normal)
            setImage(UIImage(named: "star_black"), for: .normal)
        }
        
        setTitle(L10n("APPLY_FOR_A_PREMIUM_BUTTON_TITLE"), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 10, left: -20, bottom: 10, right: 0)
        titleLabel?.font = .rubik(fontSize: fontSize, fontWeight: .bold)
    }
}
