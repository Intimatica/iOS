//
//  PublisingAgreeView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/23/21.
//

import UIKit

class PublishingAgreeView: UIView {
    enum State {
        case active, inactive
    }
    
    // MARK: - Properties
    var state: State = .inactive {
        didSet {
            switch state {
            case .active:
                actionButton.setBackgroundImage(UIImage(named: Constants.actionButtonBackgrounImageForActive), for: .normal)
            case .inactive:
                actionButton.setBackgroundImage(UIImage(named: Constants.actionButtonBackgrounImageForInactive), for: .normal)
            }
        }
    }
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: Constants.actionButtonBackgrounImageForInactive), for: .normal)
        return button
    }()
    
    private lazy var titleLabel = UILabel(font: .rubik(fontSize: .small, fontWeight: .regular),
                                              textColor: .black.withAlphaComponent(0.3),
                                              text: L10n("TELL_STORY_AGREE_TITLE"))
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(actionButton)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        actionButton.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.actionButtonHeightWidth)
            make.leading.top.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(actionButton.snp.trailing).offset(Constants.titleLabelLeading)
            make.top.trailing.bottom.equalTo(self)
        }
    }
}

// MARK: - Helper/Constants
extension PublishingAgreeView {
    struct Constants {
        static let actionButtonBackgrounImageForActive = "radio_active_purple"
        static let actionButtonBackgrounImageForInactive = "radio_inactive_gray"
        
        static let actionButtonHeightWidth: CGFloat = 30
        static let titleLabelLeading: CGFloat = 15
    }
}
