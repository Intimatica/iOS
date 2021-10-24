//
//  AuthorView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/30/21.
//

import UIKit
import Kingfisher
import SnapKit

protocol AuthorViewDelegate: AnyObject {
    func urlDidTap(url: URL)
}

final class AuthorView: UIView {
    enum Writer {
        case creator(String)
        case author(String)
    }
    
    // MARK: - Properties
    var delegate: AuthorViewDelegate?
    private var profileUrl: String?
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
        setupActions()
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
            make.leading.equalTo(self)
            make.centerY.equalTo(label.snp.centerY)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(Constants.labelLeading)
            make.trailing.equalTo(self)
            make.top.bottom.equalTo(self)
        }
    }
    
    // MARK: - Public
    func fill(by name: Writer, jobTitle: String, avatar: String, profileUrl: String?, textColor: UIColor = .black) {
        self.profileUrl = profileUrl
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: AppConstants.serverURL + avatar), options: AppConstants.kingFisherOptions)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        
        let greyTextAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.rubik(fontSize: .px14, fontWeight: .regular),
            .foregroundColor: UIColor.appDarkGray
        ]
        
        let nameTextAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.rubik(fontSize: .px14, fontWeight: .bold),
            .foregroundColor: textColor
        ]
        
        let jobTextAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.rubik(fontSize: .px14, fontWeight: .regular),
            .foregroundColor: textColor
        ]
        
        switch name {
        case .author(let name):
            let text = NSMutableAttributedString(string: L10n("AUTHOR"), attributes: greyTextAttribute)
            text.append(NSAttributedString(string: "\n"))
            text.append(NSAttributedString(string: name, attributes: nameTextAttribute))
            text.append(NSAttributedString(string: "\n"))
            text.append(NSAttributedString(string: jobTitle, attributes: jobTextAttribute))
            text.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, text.length))
            label.attributedText = text
        case .creator(let name):
            let text = NSMutableAttributedString(string: name, attributes: nameTextAttribute)
            text.append(NSAttributedString(string: "\n"))
            text.append(NSAttributedString(string: jobTitle, attributes: greyTextAttribute))
            text.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, text.length))
            label.attributedText = text
        }
    }
    
    private func setupActions() {
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector (self.showBrowser(_:)))
        self.addGestureRecognizer(tapGuesture)
    }
    
    @objc private func showBrowser(_ sender:UITapGestureRecognizer) {
        if let profileUrl = profileUrl, let url = URL(string: profileUrl) {
            delegate?.urlDidTap(url: url)
        }
    }
}

// MARK: - Helper/Constants
extension AuthorView {
    private struct Constants {
        static let imageViewWidthHeight: CGFloat = 50
        static let labelLeading: CGFloat = 14
    }
}
