//
//  StoryView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/18/21.
//

import UIKit
import SnapKit

final class StoryView: UIView {
    // MARK: - Properties
    private lazy var storyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appGrayPurple
        return view
    }()
    
    private lazy var storyLabel = UILabel(font: Constants.labelFont)
    
    private lazy var commentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.appDarkPurple.withAlphaComponent(0.3).cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var commentLabel = UILabel(font: Constants.labelFont)
    
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
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        storyView.roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: Constants.viewCornerRadius)
//        commentView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: Constants.viewCornerRadius)
    }
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(storyView)
        addSubview(commentView)
        
        storyView.addSubview(storyLabel)

        commentView.addSubview(authorView)
        commentView.addSubview(commentLabel)
    }
    
    private func setupConstraints() {
        storyView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self)
        }

        storyLabel.snp.makeConstraints { make in
            make.edges.equalTo(storyView).inset(20)
        }

        commentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self)
            make.top.equalTo(storyView.snp.bottom).offset(Constants.commentViewTop)
        }

        authorView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(commentView).inset(20)
        }

        commentLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(commentView).inset(20)
            make.top.equalTo(authorView.snp.bottom).offset(10)
        }
    }
    
    // MARK: - Public
    func fill(by story: String, and comment: String?, authorName: String?, authorJobTitle: String?, authorAvatar: String?) {
        storyLabel.text = story
        commentLabel.text = comment
        
        if let comment = comment, !comment.isEmpty {
            guard
                let authorName = authorName,
                let authorJobTitle = authorJobTitle,
                let authorAvatar = authorAvatar
            else {
                authorView.isHidden = true
                return
            }
            
            authorView.fill(by: .creator(authorName), jobTitle: authorJobTitle, avatar: authorAvatar)
        } else {
            authorView.isHidden = true
            commentView.isHidden = true
        }
    }
}

// MARK: - Helper/Constants
extension StoryView {
    struct Constants {
        static let labelFont: UIFont = .rubik(fontSize: .regular, fontWeight: .regular)
        static let viewCornerRadius: CGFloat = 20
        
        static let commentViewTop: CGFloat = 30
        
    }
}
