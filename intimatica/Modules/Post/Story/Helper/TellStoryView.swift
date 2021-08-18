//
//  File.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/18/21.
//

import UIKit

final class TellStoryView: UIView {
    // MARK: - Properties
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "tell_story_background")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .subTitle, fontWeight: .bold)
        label.text = L10n("STORY_TELL_TITLE_LABEL")
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var actionButton: UIRoundedButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .init(hex: 0xFFE70D)
        button.setTitle(L10n("STORY_TELL_BUTTON_LABEL"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .bold)
        return button
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 35
        layer.masksToBounds = true
        
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        backgroundImageView.fillSuperview()
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLeadingTrailing),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelTop),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.titleLeadingTrailing),
            // QUESTION how to remove this?
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            
            actionButton.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight),
            actionButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.actionButtonTop),
            actionButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.actionButtonBottom),
        ])
    }
}

// MARK: - Helper/Constants
extension TellStoryView {
    struct Constants {
        static let titleLabelTop: CGFloat = 40
        static let titleLeadingTrailing: CGFloat = 25
        
        static let actionButtonHeight: CGFloat = 50
        static let actionButtonTop: CGFloat = 20
        static let actionButtonBottom: CGFloat = 50
    }
}
