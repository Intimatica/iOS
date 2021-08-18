//
//  StoryView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/18/21.
//

import UIKit

final class StoryView: UIView {
    // MARK: - Properties
    private lazy var storyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Constants.labelFont
        return label
    }()
    
    private lazy var commentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.appPurple.withAlphaComponent(0.3).cgColor
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var commentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "story_comment_image")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Constants.labelFont
        return label
    }()
    
    private lazy var authorView = AuthorView()
    
    
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
        
        addSubview(storyLabel)
        addSubview(commentView)
        
        commentView.addSubview(commentImageView)
        commentView.addSubview(commentLabel)
        commentView.addSubview(authorView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            storyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            storyLabel.topAnchor.constraint(equalTo: topAnchor),
            storyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            commentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            commentView.topAnchor.constraint(equalTo: storyLabel.bottomAnchor, constant: Constants.commentViewTop),
            commentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            commentImageView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor, constant: Constants.commentImageViewLeading),
            commentImageView.topAnchor.constraint(equalTo: commentView.topAnchor, constant: Constants.commentImageViewLeading),
            commentImageView.widthAnchor.constraint(equalToConstant: Constants.commentImageViewWidth),
            commentImageView.heightAnchor.constraint(equalToConstant: Constants.commentImageViewHeight),

            commentLabel.leadingAnchor.constraint(equalTo: commentView.leadingAnchor, constant: Constants.commentLabelLeadingTrailing),
            commentLabel.topAnchor.constraint(equalTo: commentImageView.bottomAnchor, constant: Constants.commentLabelTop),
            commentLabel.trailingAnchor.constraint(equalTo: commentView.trailingAnchor, constant: -Constants.commentLabelLeadingTrailing),

            authorView.leadingAnchor.constraint(equalTo: commentLabel.leadingAnchor),
            authorView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: Constants.authorViewTop),
            authorView.trailingAnchor.constraint(equalTo: commentLabel.trailingAnchor),
            authorView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor, constant: -Constants.authorViewBottom),
        ])
    }
    
    // MARK: - Public
    func fill(by story: String, and comment: String, authorName: String, authorJobTitle: String, authorAvatar: String) {
        storyLabel.text = story
        commentLabel.text = comment
        authorView.fill(by: .creator(authorName), jobTitle: authorJobTitle, avatar: authorAvatar)
    }
}

// MARK: - Helper/Constants
extension StoryView {
    struct Constants {
        static let labelFont: UIFont = .rubik(fontSize: .regular, fontWeight: .regular)
        
        static let commentViewTop: CGFloat = 30
        static let commentImageViewTop: CGFloat = 35
        static let commentImageViewLeading: CGFloat = 30
        static let commentImageViewHeight: CGFloat = 17
        static let commentImageViewWidth: CGFloat = 25
        static let commentLabelTop: CGFloat = 15
        static let commentLabelLeadingTrailing: CGFloat = 30
        static let authorViewTop: CGFloat = 15
        static let authorViewBottom: CGFloat = 30
    }
}
