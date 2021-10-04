//
//  AuthorView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/30/21.
//

import UIKit
import Kingfisher
import SnapKit

final class AuthorView: UIView {
    enum Writer {
        case creator(String)
        case author(String)
    }
    
    // MARK: - Properties
    private lazy var imageView: AvatarImageView = {
        let imageView = AvatarImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "post_author_avatar_placeholder")
        return imageView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
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
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.imageViewWidthHeight)
            make.leading.top.bottom.equalTo(self)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.centerY)
            make.leading.equalTo(imageView.snp.trailing).offset(Constants.labelLeading)
            make.trailing.equalTo(self)
        }
    }
    
    // MARK: - Public
    func fill(by name: Writer, jobTitle: String, avatar: String, textColor: UIColor = .black) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: AppConstants.serverURL + avatar), options: AppConstants.kingFisherOptions)

        let greyTextAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.appDarkGray]
        
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
