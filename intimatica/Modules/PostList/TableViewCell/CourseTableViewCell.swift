//
//  VideoCourseTableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import UIKit

class CourseTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    lazy var courseButtonView = CourseButtonView()
    
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
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        courseButtonView.state = .inactive
    }
    
    // MARK: - Layout
    override func setupView() {
        super.setupView()
        
        postView.addSubview(courseButtonView)
        
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
            
            courseButtonView.topAnchor.constraint(equalTo: postView.topAnchor, constant: Constants.courseButtonViewTopTrailing),
            courseButtonView.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -Constants.courseButtonViewTopTrailing),
//
            postLabelView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: Constants.postLabelLeading),
            postLabelView.centerYAnchor.constraint(equalTo: courseButtonView.centerYAnchor),
            
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
    
    private func setupActions() {
        courseButtonView.actionButton.addAction { [weak self] in
            guard let self = self else { return }
            
            self.courseButtonView.toggleState()
            
            switch self.courseButtonView.state {
            case .inactive:
                self.delegate?.removeFromFavorites(by: self.indexPath)
            case .active:
                self.delegate?.addToFavorites(by: self.indexPath)
            }
        }
    }
    
    // MARK: - Public
    override func fill(by post: Post, isFavorite: Bool = false, indexPath: IndexPath, delegate: BaseTableViewCellDelegate?) {
        super.fill(by: post, isFavorite: isFavorite, indexPath: indexPath, delegate: delegate)
        
        if isFavorite {
            courseButtonView.state = .active
        }
    }
}

// MARK: - Helper/Constraints
extension CourseTableViewCell.Constants {
    static let CourseBackgroundImageViewHeight: CGFloat = 340
    static let tagStackView: CGFloat = titleLabelTop
    static let postLabelColor: UIColor = .appPurple
    
    static let courseButtonViewTopTrailing: CGFloat = 15
}
