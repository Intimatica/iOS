//
//  StoryViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/17/21.
//

import UIKit

class StoryViewController: BasePostViewController {
    // MARK: - Properties
    private let presenter: StoryPresenterProtocol
    
    private lazy var storyView = StoryView()
    private lazy var tellStoryView = TellStoryView(screen: .story)
    private lazy var allowedPublishingView = AllowedPublishingView()

    
    // MARK: - Initializers
    init(presenter: StoryPresenterProtocol) {
        self.presenter = presenter
        
        super.init(presenter: presenter,  rightBarButtonType: .favorite)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupActions()
        
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        contentView.addSubview(headerImageView)
        contentView.addSubview(headerStack)
        contentView.addSubview(storyView)
        contentView.addSubview(allowedPublishingView)
        contentView.addSubview(tellStoryView)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(tagsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 200),

            headerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.headerStackLeadingTrailing),
            headerStack.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: Constants.headerStackTop),
            headerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.headerStackLeadingTrailing),
            
            storyView.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            storyView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: Constants.storyViewTop),
            storyView.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            
            allowedPublishingView.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            allowedPublishingView.topAnchor.constraint(equalTo: storyView.bottomAnchor, constant: Constants.allowedPublishingViewTop),
            allowedPublishingView.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            
            tellStoryView.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            tellStoryView.topAnchor.constraint(equalTo: allowedPublishingView.bottomAnchor, constant: Constants.tellStoryViewTop),
            tellStoryView.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            tellStoryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.tellStoryViewBottom)
        ])
    }
    
    private func setupActions() {
        tellStoryView.actionButton.addAction { [weak self] in
            self?.presenter.tellStoryButtonDidTap()
        }
    }
}

// MARK: - StoryViewProtocol
extension StoryViewController: StoryViewProtocol {
    func display(_ post: StoryPostQuery.Data.Post) {
        guard
            let imageUrl = post.image?.url,
            let tags = post.tags?.compactMap({ $0?.name }),
            let authorName = post.author?.name,
            let authorJobTitle = post.author?.jobTitle,
            let authorPhotoUrl = post.author?.photo?.url,
            let story = post.postTypeDz.first??.asComponentPostTypeStory?.story,
            let comment = post.postTypeDz.first??.asComponentPostTypeStory?.comment
        else {
            return
        }
        
        headerImageView.kf.indicatorType = .activity
        headerImageView.kf.setImage(with: URL(string: AppConstants.serverURL + imageUrl))
        
        titleLabel.text = post.title
        tagsStackView.fill(by: tags)
        storyView.fill(by: story, and: comment, authorName: authorName, authorJobTitle: authorJobTitle, authorAvatar: authorPhotoUrl)
        
        hideActivityIndicator()
        
        addToAnalytics(postId: post.id, postTitle: post.title)
    }
}

// MARK: - Helper/Constants
extension StoryViewController.Constants {
    static let allowedPublishingViewTop: CGFloat = 15
    
    static let storyViewTop: CGFloat = 20
    static let tellStoryViewTop: CGFloat = 30
    static let tellStoryViewBottom: CGFloat = 50
}
