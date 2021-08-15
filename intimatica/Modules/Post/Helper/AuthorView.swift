//
//  AuthorView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/30/21.
//

import UIKit

final class AuthorView: UIView {
    
    lazy var imageView: AvatarImageView = {
        let imageView = AvatarImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "post_author_avatar_placeholder")
        return imageView
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
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
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewWidthHeight),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewWidthHeight),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.labelLeading),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension AuthorView {
    private struct Constants {
        static let imageViewWidthHeight: CGFloat = 50
        static let labelLeading: CGFloat = 13
    }
}
