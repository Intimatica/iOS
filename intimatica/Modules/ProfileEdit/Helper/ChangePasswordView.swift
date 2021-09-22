//
//  ChangePasswordView.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/22/21.
//

import UIKit

class ChangePasswordView: UIView {
    // MARK: - Properies
    private lazy var topSpacer = SpacerView(height: 1, backgroundColor: .appPalePurple)
    private lazy var bottomSpacer = SpacerView(height: 1, backgroundColor: .appPalePurple)
    
    private lazy var passwordImageView = UIImageView(name: "Password", contentMode: .scaleAspectFill)
    
    private lazy var titleLabel = UILabel(font: .rubik(fontSize: .regular, fontWeight: .regular),
                                          textColor: .black,
                                          text: L10n("PROFILE_CHANGE_PASSWORD"))
    
    private lazy var forwardImageView = UIImageView(name: "forward_icon", contentMode: .scaleAspectFill)
    
    lazy var actionButton = UIButton()
    
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
        addSubview(topSpacer)
        addSubview(passwordImageView)
        addSubview(titleLabel)
        addSubview(forwardImageView)
        addSubview(bottomSpacer)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(Constants.viewHeight)
        }
        
        topSpacer.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self)
        }
        
        bottomSpacer.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(self)
        }
        
        passwordImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.passwordImageViewLeading)
            make.leading.equalTo(self).offset(Constants.passwordImageViewLeading)
            make.centerY.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwordImageView.snp.trailing).offset(Constants.titleLabelLeading)
            make.centerY.equalTo(self)
        }
        
        forwardImageView.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-Constants.letforwardImageViewTrailing)
            make.centerY.equalTo(self)
        }
        
        actionButton.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(self)
        }
    }
}

// MARK: - Helper/Constants
extension ChangePasswordView {
    struct Constants {
        static let viewHeight: CGFloat = 64
        static let borderHeight: CGFloat = 1
        static let borderColor: UIColor = .appPalePurple
        
        static let passwordImageViewWidthHeight: CGFloat = 19
        static let passwordImageViewLeading: CGFloat = 25
        static let titleLabelLeading: CGFloat = 10
        static let forwardImageViewWidth: CGFloat = 7
        static let letforwardImageViewTrailing: CGFloat = 25
    }
}
