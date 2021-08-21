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
        
        tagStackView.clear()
    }

    // MARK: - Public
    func fill(by story: UserStoriesQuery.Data.Story) {
        titleLabel.text = story.story
        
        if let comment = story.comment, !comment.isEmpty  {
            tagStackView.add(.published)
        } else {
            tagStackView.add(.underConsideration)
        }
        
        tagStackView.add(.nonPublic)
    }
    
    // MARK: - Private
    private func setupView() {
        selectionStyle = .none
        
        contentView.addSubview(storyImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(tagStackView)
    }
    
    private func setupConstraints() {
        storyImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.storyImageViewLeading)
            make.top.equalTo(titleLabel.snp.top)
            make.bottom.equalTo(tagStackView.snp.bottom)
            make.width.equalTo(storyImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(storyImageView.snp.trailing).offset(Constants.titleLabelLeadingTrailing)
            make.top.equalTo(contentView).offset(Constants.titleLabelTop)
            make.trailing.equalTo(contentView).offset(-Constants.titleLabelLeadingTrailing)
        }
        
        tagStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.tagStackViewTop)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
        }
    }
}

// MARK: - Helper/Constants
extension StoryTableViewCell {
    struct Constants {
        static let storyImageViewLeading: CGFloat = 25
        static let titleLabelTop: CGFloat = 30
        static let titleLabelLeadingTrailing: CGFloat = 25
        static let tagStackViewTop: CGFloat = 18
    }
}
