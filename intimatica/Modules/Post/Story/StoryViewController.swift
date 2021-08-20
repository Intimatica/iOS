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
    private lazy var tellStoryView = TellStoryView()
    
    private lazy var agreeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n("STORY_AGREE_LABEL")
        label.font = .rubik(fontSize: .small, fontWeight: .regular)
        label.textColor = .init(hex: 0xB7B7B7)
        return label
    }()
    
    private lazy var agreeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "course_selection_button_image_active")
        return imageView
    }()
    
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
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(headerStack)
        scrollView.addSubview(storyView)
        scrollView.addSubview(agreeLabel)
        scrollView.addSubview(agreeImageView)
        scrollView.addSubview(tellStoryView)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(tagsStackView)
    }
    
    private func setupConstraints() {
        let contentLayoutGuide = scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            headerImageView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            headerImageView.widthAnchor.constraint(equalTo: view.widthAnchor),

            headerStack.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: Constants.headerStackLeadingTrailing),
            headerStack.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: Constants.headerStackTop),
            headerStack.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: -Constants.headerStackLeadingTrailing),
            
            storyView.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            storyView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: Constants.storyViewTop),
            storyView.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            
            agreeImageView.heightAnchor.constraint(equalToConstant: Constants.agreeImageViewHeightWidth),
            agreeImageView.widthAnchor.constraint(equalToConstant: Constants.agreeImageViewHeightWidth),
            agreeImageView.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            agreeImageView.centerYAnchor.constraint(equalTo: agreeLabel.centerYAnchor),
            
            agreeLabel.leadingAnchor.constraint(equalTo: agreeImageView.trailingAnchor, constant: Constants.agreeLabelLeading),
            agreeLabel.topAnchor.constraint(equalTo: storyView.bottomAnchor, constant: Constants.agreeLabelTop),
            agreeLabel.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            
            tellStoryView.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            tellStoryView.topAnchor.constraint(equalTo: agreeLabel.bottomAnchor, constant: Constants.tellStoryViewTop),
            tellStoryView.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            tellStoryView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
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
        
        hideSpinner()
    }
    
    func display(_ error: Error) {
        
    }
}

// MARK: - Helper/Constants
extension StoryViewController.Constants {
    static let agreeImageViewHeightWidth: CGFloat = 14
    static let agreeLabelLeading: CGFloat = 10
    static let agreeLabelTop: CGFloat = 15
    
    static let storyViewTop: CGFloat = 20
    static let tellStoryViewTop: CGFloat = 30
}
