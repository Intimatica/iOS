//
//  PremiumCourseLabel.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/9/21.
//

import UIKit

final class PremiumCouseLabel: UIView {
    // MARK: - Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "star")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n("TABLE_CELL_POST_LABEL_PRIMIUM_COURSE")
        label.font = .rubik(fontSize: .small, fontWeight: .medium)
        label.textColor = .init(hex: 0xFFE70D)
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        layer.cornerRadius = Constants.viewCornerRadius
        layer.masksToBounds = true
        
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.imageViewLeading),
            imageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewWidthHeight),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewWidthHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.titleLabelLeading),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelTopBottom),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.titleLabelTrailing),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.titleLabelTopBottom)
        ])
    }
}

// MARK: Helper/Constants
extension PremiumCouseLabel  {
    struct Constants {
        static let viewCornerRadius: CGFloat = 10
        
        static let imageViewLeading: CGFloat = 10
        static let imageViewWidthHeight: CGFloat = 11
        static let titleLabelLeading: CGFloat = 5
        static let titleLabelTopBottom: CGFloat = 3
        static let titleLabelTrailing: CGFloat = 10
    }
}
