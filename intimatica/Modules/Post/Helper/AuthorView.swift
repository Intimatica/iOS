//
//  AuthorView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/30/21.
//

import UIKit
import Kingfisher

final class AuthorView: UIView {
    enum Writer {
        case creator(String)
        case author(String)
    }
    
    // MARK: - Properties
    private lazy var imageView: AvatarImageView = {
        let imageView = AvatarImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "post_author_avatar_placeholder")
        return imageView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .subRegular, fontWeight: .regular)
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
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // MARK: - Public
    func fill(by name: Writer, jobTitle: String, avatar: String, textColor: UIColor = .black) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: AppConstants.serverURL + avatar), options: AppConstants.kingFisherOptions)

        let greyTextAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.appGray]
        
        let nameTextAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: label.font.pointSize),
                                                                .foregroundColor: textColor]
        
        let jobTextAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: textColor]
        
        switch name {
        case .author(let name):
            let text = NSMutableAttributedString(string: L10n("AUTHOR"), attributes: greyTextAttribute)
            text.append(NSAttributedString(string: "\n"))
            text.append(NSAttributedString(string: name, attributes: nameTextAttribute))
            text.append(NSAttributedString(string: "\n"))
            text.append(NSAttributedString(string: jobTitle, attributes: jobTextAttribute))
            label.attributedText = text
        case .creator(let name):
            let text = NSMutableAttributedString(string: name, attributes: nameTextAttribute)
            text.append(NSAttributedString(string: "\n"))
            text.append(NSAttributedString(string: jobTitle, attributes: greyTextAttribute))
            label.attributedText = text
        }
    }
}

// MARK: - Helper/Constants
extension AuthorView {
    private struct Constants {
        static let imageViewWidthHeight: CGFloat = 50
        static let labelLeading: CGFloat = 13
    }
}
