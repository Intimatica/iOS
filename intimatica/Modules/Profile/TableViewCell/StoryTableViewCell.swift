//
//  StoryTableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/21/21.
//

import UIKit
import SnapKit

class StoryTableViewCell: UITableViewCell {
    // MARK: - Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    private lazy var containerView = UIView()
    
    private lazy var storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cell_image")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(font: .rubik(fontSize: .regular, fontWeight: .regular))
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var tagStackView = StoryTagStackView()

    private lazy var showButton: UIRoundedButton = {
        let button = UIRoundedButton(title: L10n("MY_STORY_FEED_SHOW_STORY_BUTTON_TITLE"),
                                     titleColor: .white,
                                     font: .rubik(fontSize: .regular, fontWeight: .bold),
                                     backgroundColor: .appPurple)
        button.isUserInteractionEnabled = false
        button.isHidden = true
        return button
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        showButton.isHidden = true
        tagStackView.clear()
    }

    // MARK: - Public
    func fill(by story: UserStoriesQuery.Data.Story) {
        titleLabel.text = story.story
        
        if let comment = story.comment, !comment.isEmpty  {
            showButton.isHidden = false
        }
        
        if let allowPublishing = story.allowPublishing, !allowPublishing {
            tagStackView.add(.nonPublic)
        }
        
        if let isPublished = story.isPublished, isPublished {
            tagStackView.add(.published)
        } else {
            tagStackView.add(.underConsideration)
        }
    }
    
    // MARK: - Private
    private func setupView() {
        selectionStyle = .none
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(containerView)
        stackView.addArrangedSubview(showButton)

        containerView.addSubview(storyImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(tagStackView)
    }
    
    private func setupConstraints() {
    
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.stackViewLeadingTrailing)
            make.top.bottom.equalTo(contentView).inset(Constants.stackViewTopBottom)
        }
        
        storyImageView.snp.makeConstraints { make in
            make.leading.equalTo(containerView)
            make.top.equalTo(titleLabel)
            make.bottom.equalTo(tagStackView.snp.bottom)
            make.width.equalTo(storyImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(storyImageView.snp.trailing).offset(Constants.titleLabelLeading)
            make.top.equalTo(containerView)
            make.trailing.equalTo(containerView)
        }
        
        tagStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.tagStackViewTop)
            make.bottom.equalTo(containerView.snp.bottom)
        }
   
        showButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.showButtonHeight)
        }
    }
}

// MARK: - Helper/Constants
extension StoryTableViewCell {
    struct Constants {
        static let stackViewSpacing: CGFloat = 30
        static let stackViewLeadingTrailing: CGFloat = 30
        static let stackViewTopBottom:  CGFloat = 25
        
        static let titleLabelLeading: CGFloat = 25
        static let tagStackViewTop: CGFloat = 18
        static let showButtonHeight: CGFloat = 50
    }
}
