//
//  File.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/18/21.
//

import UIKit

protocol TellStoryViewConstantsProtocol {
    var titleLabelFont: UIFont { get }
    var backgroundImageName: String { get }
    var titleText: String { get }
    var actionButtonText: String { get }
    
    var titleLabelTop: CGFloat { get }
    var titleLeadingTrailing: CGFloat { get }
    
    var actionButtonHeight: CGFloat { get }
    var actionButtonTop: CGFloat { get }
    var actionButtonBottom: CGFloat { get }
}

final class TellStoryView: UIView {
    enum Screen {
        case story
        case profile
    }
    
    // MARK: - Properties
    private let settings: TellStoryViewConstantsProtocol
    
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
    init(screen: Screen) {
        switch screen {
        case .story:
            settings = StoryConstants()
        case .profile:
            settings = ProfileConstants()
        }
        
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
        
        backgroundImageView.image = UIImage(named: settings.backgroundImageName)
        titleLabel.text = settings.titleText
        titleLabel.font = settings.titleLabelFont
        actionButton.setTitle(settings.actionButtonText, for: .normal)
        
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        backgroundImageView.fillSuperview()
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: settings.titleLeadingTrailing),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: settings.titleLabelTop),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -settings.titleLeadingTrailing),
            // QUESTION how to remove this?
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            
            actionButton.heightAnchor.constraint(equalToConstant: settings.actionButtonHeight),
            actionButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actionButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: settings.actionButtonTop),
            actionButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -settings.actionButtonBottom),
        ])
    }
}

// MARK: - Helper/Constants
extension TellStoryView {
    struct StoryConstants: TellStoryViewConstantsProtocol {
        var titleLabelFont: UIFont = .rubik(fontSize: .subTitle, fontWeight: .bold)
        var backgroundImageName: String = "tell_story_background"
        var titleText: String = L10n("STORY_TELL_TITLE_LABEL")
        var actionButtonText: String = L10n("STORY_TELL_BUTTON_LABEL")
        
        let titleLabelTop: CGFloat = 40
        let titleLeadingTrailing: CGFloat = 25
        
        let actionButtonHeight: CGFloat = 50
        let actionButtonTop: CGFloat = 20
        let actionButtonBottom: CGFloat = 50
    }
    
    struct ProfileConstants: TellStoryViewConstantsProtocol {
        var titleLabelFont: UIFont = .rubik(fontSize: .regular, fontWeight: .bold)
        var backgroundImageName: String = "tellstory_background_for_profile"
        var titleText: String = L10n("PROFILE_TELL_TITLE_LABEL")
        var actionButtonText: String = L10n("PROFILE_TELL_BUTTON_LABEL")
        
        let titleLabelTop: CGFloat = 25
        let titleLeadingTrailing: CGFloat = 25
        
        let actionButtonHeight: CGFloat = 50
        let actionButtonTop: CGFloat = 10
        let actionButtonBottom: CGFloat = 25
    }
}
