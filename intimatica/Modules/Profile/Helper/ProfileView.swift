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
    
    lazy var editProfileButton: UIRoundedButton = {
        let button = UIRoundedButton()
        button.setImage(UIImage(named: "settings_button_icon"), for: .normal)
        return button
    }()
    
    lazy var premiumButton = ApplyForPremiumButton(desing: .yellow)
    
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
        backgroundColor = .appDarkPurple
        
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
            make.leading.equalTo(self).offset(Constants.avatarImageViewLeading)
            make.top.equalTo(self).offset(Constants.avatarImageViewTop)
        }
        
        nameStackView.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Constants.nameStackViewLeadingTrailing)
            make.trailing.equalTo(self).offset(-Constants.nameStackViewLeadingTrailing)
            make.centerY.equalTo(avatarImageView.snp.centerY)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.editProfileButtonHeight)
            make.centerY.equalTo(avatarImageView.snp.centerY)
            make.trailing.equalTo(self).offset(-Constants.editProfileButtonLeadingTrailing)
        }
        
        premiumButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.premiumButtonHeight)
            make.leading.trailing.equalTo(self).inset(Constants.premiumButtonLeadingTrailing)
            make.top.equalTo(avatarImageView.snp.bottom).offset(Constants.premiumButtonTop)
            make.bottom.equalTo(self).offset(-Constants.premiumButtonBottom)
        }
    }
    
    // MARK: - Public
    func fill(by nickname: String?, and email: String) {
        emailLabel.text = email
        
        if let nickname = nickname {
            nicknameLabel.text = nickname
        } else {
            nicknameLabel.isHidden = true
        }
    }
}

// MARK: - Helper/Constants
extension ProfileView {
    struct Constants {
        static let nameStackViewSpacing: CGFloat = 0
        
        static let avatarImageViewWidthHeight: CGFloat = 60
        static let avatarImageViewTop: CGFloat = 30
        static let avatarImageViewLeading: CGFloat = 15
        
        static let nameStackViewLeadingTrailing: CGFloat = 20
        
        static let editProfileButtonHeight: CGFloat = 40
        static let editProfileButtonTop: CGFloat = 30
        static let editProfileButtonLeadingTrailing: CGFloat = 15
        
        static let premiumButtonHeight: CGFloat = 50
        static let premiumButtonTop: CGFloat = 25
        static let premiumButtonLeadingTrailing: CGFloat = 15
        static let premiumButtonBottom: CGFloat = 30
    }
}
