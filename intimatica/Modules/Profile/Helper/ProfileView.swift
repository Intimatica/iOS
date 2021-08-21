//
//  ProfileView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/21/21.
//

import UIKit
import SnapKit

final class ProfileView: UIView {
    // MARK: - Properties
    private lazy var avatarImageView: AvatarImageView = {
        let imageView = AvatarImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.nameStackViewSpacing
        return stackView
    }()
    
    private lazy var nicknameLabel: UILabel = UILabel(font: .rubik(fontSize: .subTitle, fontWeight: .bold),
                                                  textColor: .white)
    private lazy var emailLabel: UILabel = UILabel(font: .rubik(fontSize: .regular, fontWeight: .regular),
                                                   textColor: .white)
    
    private lazy var editProfileButton: UIRoundedButton = {
        let button = UIRoundedButton(title: L10n("EDIT_PROFILE_BUTTON_TITLE"),
                                     titleColor: .white,
                                     font: .rubik(fontSize: .regular, fontWeight: .bold),
                                     backgroundColor: .clear)
        
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var premiumButton: UIRoundedButton = {
        let button = UIRoundedButton(title: L10n("APPLY_FOR_A_PREMIUM_BUTTON_TITLE"),
                                     titleColor: .black,
                                     font: .rubik(fontSize: .regular, fontWeight: .bold),
                                     backgroundColor: .init(hex: 0xFFE70D))
        return button
    }()
    
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
        backgroundColor = .appPurple
        
        addSubview(avatarImageView)
        addSubview(nameStackView)
        addSubview(editProfileButton)
        addSubview(premiumButton)
        
        nameStackView.addArrangedSubview(nicknameLabel)
        nameStackView.addArrangedSubview(emailLabel)
    }
    
    private func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.avatarImageViewWidthHeight)
            make.leading.equalTo(view).offset(Constants.avatarImageViewLeading)
            make.top.equalTo(view).offset(Constants.avatarImageViewTop)
        }
        
        nameStackView.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Constants.nameStackViewLeadingTrailing)
            make.trailing.equalTo(view).offset(-Constants.nameStackViewLeadingTrailing)
            make.centerY.equalTo(avatarImageView.snp.centerY)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.editProfileButtonHeight)
            make.leading.equalTo(view).offset(Constants.editProfileButtonLeadingTrailing)
            make.top.equalTo(avatarImageView.snp.bottom).offset(Constants.editProfileButtonTop)
            make.trailing.equalTo(view).offset(-Constants.editProfileButtonLeadingTrailing)
        }
        
        premiumButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.premiumButtonHeight)
            make.leading.trailing.equalTo(editProfileButton)
            make.top.equalTo(editProfileButton.snp.bottom).offset(Constants.premiumButtonTop)
            make.bottom.equalTo(view).offset(-Constants.premiumButtonBottom)
        }
    }
    
    // MARK: - Public
    func fill(by nickname: String, and email: String) {
        nicknameLabel.text = nickname
        emailLabel.text = email
    }
}

// MARK: - Helper/Constants
extension ProfileView {
    struct Constants {
        static let nameStackViewSpacing: CGFloat = 0
        
        static let avatarImageViewWidthHeight: CGFloat = 90
        static let avatarImageViewTop: CGFloat = 30
        static let avatarImageViewLeading: CGFloat = 25
        
        static let nameStackViewLeadingTrailing: CGFloat = 20
        
        static let editProfileButtonHeight: CGFloat = 40
        static let editProfileButtonTop: CGFloat = 30
        static let editProfileButtonLeadingTrailing: CGFloat = 25
        
        static let premiumButtonHeight: CGFloat = 50
        static let premiumButtonTop: CGFloat = 20
        static let premiumButtonBottom: CGFloat = 50
    }
}
