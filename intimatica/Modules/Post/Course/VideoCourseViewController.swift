//
//  VideoCourseViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/5/21.
//

import UIKit

class VideoCourseViewController: BasePostViewController {
    typealias Video = VideoCoursePostQuery.Data.Post.PostTypeDz.AsComponentPostTypeVideoCourse.Video
    
    // MARK: - Properties
    private let presenter: VideoCoursePresenterProtocol
    private var videoList: [Video] = []
    
    private lazy var courseTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .subTitle, fontWeight: .medium)
        label.textColor = .black
        label.text = L10n("COURSE_POST_TITLE")
        return label
    }()
    
    private lazy var videoTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .subTitle, fontWeight: .medium)
        label.textColor = .black
        label.text = L10n("COURSE_VIDEO_TITLE")
        return label
    }()
    
    private lazy var videoStack: UIStackView =  {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.videoStackSpacing
        return stack
    }()
    
    private lazy var finishButton: UIRoundedButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .appPurple
        button.setTitle(L10n("COURSE_VIDEO_FINISH_BUTTON_TITLE"), for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .bold)
        return button
    }()
    
    // MARK: - Initializers
    init(presenter: VideoCoursePresenterProtocol) {
        self.presenter = presenter
        
        super.init(presenter: presenter, navigationBarType: .addCourse)
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
    
    // MARK: - Layout
    private func setupView() {
        spacerView.backgroundColor = .appLightPuple
        
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(headerStack)
        scrollView.addSubview(courseTitle)
        scrollView.addSubview(markdownView)
        scrollView.addSubview(spacerView)
        scrollView.addSubview(videoTitle)
        scrollView.addSubview(videoStack)
        scrollView.addSubview(finishButton)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(tagsStack)
        headerStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .clear))
        headerStack.addArrangedSubview(authorView)
        headerStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .clear))
        headerStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .appLightPuple))
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
                        
            courseTitle.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            courseTitle.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: Constants.courseTitleTop),
            courseTitle.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            
            markdownView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            markdownView.topAnchor.constraint(equalTo: courseTitle.bottomAnchor, constant: Constants.markdownViewTop),
            markdownView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            
            spacerView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            spacerView.topAnchor.constraint(equalTo: markdownView.bottomAnchor, constant: Constants.videoSectionSpacerTop),
            spacerView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            
            videoTitle.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            videoTitle.topAnchor.constraint(equalTo: spacerView.bottomAnchor, constant: Constants.videoTitleTop),
            videoTitle.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            
            videoStack.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            videoStack.topAnchor.constraint(equalTo: videoTitle.bottomAnchor, constant: Constants.videoStackTop),
            videoStack.widthAnchor.constraint(equalTo: headerStack.widthAnchor),
            
            finishButton.heightAnchor.constraint(equalToConstant: Constants.finishButtonHeight),
            finishButton.leadingAnchor.constraint(equalTo: videoStack.leadingAnchor),
            finishButton.topAnchor.constraint(equalTo: videoStack.bottomAnchor, constant: Constants.finishButtonTop),
            finishButton.trailingAnchor.constraint(equalTo: videoStack.trailingAnchor),
            finishButton.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant:  -Constants.finishButtonBottom),
        ])
    }
    
    private func setupActions() {
        finishButton.addAction { [weak self] in
            self?.presenter.finishButtonDidTap()
        }
    }
}

// MARK: - Helper/Constants
extension VideoCourseViewController.Constants {
    static let courseTitleTop: CGFloat = 30
    static let videoSectionSpacerTop: CGFloat = 30
    static let videoTitleTop: CGFloat = 30
    static let videoStackSpacing: CGFloat = 40
    static let videoStackTop: CGFloat = 20
    static let finishButtonHeight: CGFloat = 50
    static let finishButtonTop: CGFloat = 40
    static let finishButtonBottom: CGFloat = 20
}

// MARK: - VideoCourseViewProtocol
extension VideoCourseViewController: VideoCourseViewProtocol {
    func display(_ post: VideoCoursePostQuery.Data.Post) {
        guard
            let imageUrl = post.image?.url,
            let tags = post.tags?.compactMap({ $0?.name }),
            let authorName = post.author?.name,
            let authorJobTitle = post.author?.jobTitle,
            let authorPhotoUrl = post.author?.photo?.url,
            let content = post.postTypeDz.first??.asComponentPostTypeVideoCourse?.description,
            let videoList = post.postTypeDz.first??.asComponentPostTypeVideoCourse?.video?.compactMap({ $0 })
        else {
            return
        }
        
        headerImageView.kf.indicatorType = .activity
        headerImageView.kf.setImage(with: URL(string: AppConstants.serverURL + imageUrl))
        
        titleLabel.text = post.title
        
        tags.forEach { tagName in
            tagsStack.addArrangedSubview(createTagView(with: tagName))
        }
        tagsStack.addArrangedSubview(UIView())
        
        authorView.imageView.kf.indicatorType = .activity
        authorView.imageView.kf.setImage(with: URL(string: AppConstants.serverURL + authorPhotoUrl))
        authorView.label.setAttributedText(withString: L10n("AUTHOR") + "\n" + authorName + "\n" + authorJobTitle,
                                           boldString: authorName,
                                           font: authorView.label.font)
        
        markdownView.load(markdown: fixContentStrapiLinks(content), enableImage: true)
        
        self.videoList = videoList

        videoList.forEach {
            videoStack.addArrangedSubview(VideoView(videoId: $0.youtubeLink, title: $0.title))
            
            if !videoList.isLast(element: $0) {
                videoStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .appLightPuple))
            }
        }
                
        markdownView.onRendered = { [weak self] height in
            self?.hideSpinner()
            self?.markdownView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// MARK: - VideoCoursePostQuery/Equatable
extension VideoCoursePostQuery.Data.Post.PostTypeDz.AsComponentPostTypeVideoCourse.Video: Equatable {
    public static func == (lhs: VideoCoursePostQuery.Data.Post.PostTypeDz.AsComponentPostTypeVideoCourse.Video, rhs: VideoCoursePostQuery.Data.Post.PostTypeDz.AsComponentPostTypeVideoCourse.Video) -> Bool {
        lhs.title == rhs.title && lhs.youtubeLink == rhs.youtubeLink
    }
}
