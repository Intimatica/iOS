//
//  UserStoryViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/23/21.
//

import UIKit
import SnapKit
import Apollo

class UserStoryViewController: UIViewController {
    // MARK: - Properties
    private let story: UserStoriesQuery.Data.Story
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var storyView = StoryView()
    private lazy var allowedPublishingView = AllowedPublishingView()
    
    private lazy var backBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "    "
        barButton.tintColor = .appDarkPurple
        return barButton
    }()
    
    // MARK: - Initializers
    init(story: UserStoriesQuery.Data.Story) {
        self.story = story
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = backBarButtonItem
        navigationController?.navigationBar.shadowImage = UIImage()
        
        setupView()
        setupConstraints()
    }

    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(storyView)
//        contentView.addSubview(allowedPublishingView)
        
        storyView.fill(by: story.story,
                       and: story.comment,
                       authorName: story.commentAuthor?.name,
                       authorJobTitle: story.commentAuthor?.jobTitle,
                       authorAvatar: story.commentAuthor?.photo?.url)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.leading.trailing.equalTo(view)
        }
        
        storyView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(25)
            make.top.bottom.equalTo(contentView).inset(50)
        }
        
//        allowedPublishingView.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(storyView)
//            make.top.equalTo(storyView.snp.bottom).offset(30)
//            make.bottom.equalTo(contentView).offset(-30)
//        }
    }
}

// MARK: - Helper/Constants
extension UserStoryViewController {
    struct Constants {
        static let storyViewLeadingTrailing: CGFloat = 25
        static let storyViewTopBottom: CGFloat = 50
    }
}
