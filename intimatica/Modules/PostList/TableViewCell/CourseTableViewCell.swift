//
//  VideoCourseTableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import UIKit

class CourseTableViewCell: BaseTableViewCell {
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    override func setupView() {
        super.setupView()
        
        titleLabel.textColor = .white
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
            backgroundImageView.bottomAnchor.constraint(equalTo: postView.bottomAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: Constants.CourseBackgroundImageViewHeight),
            
            postLabelView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: Constants.postLabelLeading),
            postLabelView.topAnchor.constraint(equalTo: postView.topAnchor, constant: 18),
            
            tagStackView.heightAnchor.constraint(equalToConstant: Constants.tagStackViewHeight),
            tagStackView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: Constants.tagStackViewLeadingTrailing),
//            tagStackView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: Constants.tagStackViewTop),
            tagStackView.trailingAnchor.constraint(lessThanOrEqualTo: postView.trailingAnchor, constant: -Constants.tagStackViewLeadingTrailing),
            tagStackView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Constants.tagStackView),
            
            titleLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: Constants.titleLabelLeadingTrailing),
            titleLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -Constants.titleLabelLeadingTrailing),
            titleLabel.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -Constants.titleLabelBottom)
        ])
    }
}

// MARK: - Helper/Constraints
extension CourseTableViewCell.Constants {
    static let CourseBackgroundImageViewHeight: CGFloat = 340
    static let tagStackView: CGFloat = titleLabelTop
    static let postLabelColor: UIColor = .appPurple
}
