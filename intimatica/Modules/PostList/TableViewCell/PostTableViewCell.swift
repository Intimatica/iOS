//
//  StoryTableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import UIKit

class PostTableViewCell: BaseTableViewCell {
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        playButtonImageView.isHidden = true
        favoriteButtonView.state = .inactive
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lauout
    override func setupView() {
        super.setupView()
        
        postView.addSubview(favoriteButtonView)
        postView.addSubview(playButtonImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            postView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.postViewLeadingTrailing),
            postView.topAnchor.constraint(equalTo: view.topAnchor),
            postView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.postViewLeadingTrailing),
            postView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.postViewSpacing),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: postView.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: postView.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: postView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: Constants.backgroundImageViewHeight),
        
            favoriteButtonView.topAnchor.constraint(equalTo: postView.topAnchor, constant: Constants.favoriteButtonViewTopTrailing),
            favoriteButtonView.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -Constants.favoriteButtonViewTopTrailing),
            
            postLabelView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: Constants.postLabelLeading),
            postLabelView.centerYAnchor.constraint(equalTo: favoriteButtonView.centerYAnchor),

            tagStackView.heightAnchor.constraint(equalToConstant: Constants.tagStackViewHeight),
            tagStackView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: Constants.tagStackViewLeadingTrailing),
            tagStackView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: Constants.tagStackViewTop),
            tagStackView.trailingAnchor.constraint(lessThanOrEqualTo: postView.trailingAnchor, constant: -Constants.tagStackViewLeadingTrailing),
            
            titleLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: Constants.titleLabelLeadingTrailing),
            titleLabel.topAnchor.constraint(equalTo: tagStackView.bottomAnchor, constant: Constants.titleLabelTop),
            titleLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -Constants.titleLabelLeadingTrailing),
            titleLabel.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -Constants.titleLabelBottom),
            
            playButtonImageView.heightAnchor.constraint(equalToConstant: Constants.playImageViewWidthHeight),
            playButtonImageView.widthAnchor.constraint(equalToConstant: Constants.playImageViewWidthHeight),
            playButtonImageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            playButtonImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor)
        ])
    }
    
    private func setupActions() {
        favoriteButtonView.actionButton.addAction { [weak self] in
            guard let self = self else { return }
            
            self.favoriteButtonView.toggleState()
            
            switch self.favoriteButtonView.state {
            case .inactive:
                self.delegate?.removeFromFavorites(by: self.indexPath)
            case .active:
                self.delegate?.addToFavorites(by: self.indexPath)
            }
        }
    }
}
