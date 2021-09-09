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
    
    private lazy var premiumVideoCourseLabel = PremiumCourseLabel()
    private lazy var premiumHeaderBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appDarkPurple
        return view
    }()

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
        button.backgroundColor = .appDarkPurple
        button.setTitle(L10n("COURSE_VIDEO_FINISH_BUTTON_TITLE"), for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .bold)
        return button
    }()
    
    private lazy var paidCourseBlockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = true
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        return view
    }()
    
    // MARK: - Initializers
    init(presenter: VideoCoursePresenterProtocol) {
        self.presenter = presenter
        
        super.init(presenter: presenter,  rightBarButtonType: .course)
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
        spacerView.backgroundColor = .appPurple
        
        contentView.addSubview(premiumHeaderBackgroundView)
        contentView.addSubview(headerImageView)
        contentView.addSubview(headerStack)
        contentView.addSubview(courseTitle)
        contentView.addSubview(markdownView)
        contentView.addSubview(spacerView)
        contentView.addSubview(videoTitle)
        contentView.addSubview(videoStack)
        contentView.addSubview(finishButton)
        contentView.addSubview(paidCourseBlockView)
        
        contentView.addSubview(premiumVideoCourseLabel)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(tagsStackView)
        headerStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .clear))
        headerStack.addArrangedSubview(authorView)
        headerStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .clear))
        headerStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .appPurple))
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 310),

            premiumHeaderBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            premiumHeaderBackgroundView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor),
            premiumHeaderBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            premiumHeaderBackgroundView.bottomAnchor.constraint(equalTo: headerStack.bottomAnchor),
            
            premiumVideoCourseLabel.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            premiumVideoCourseLabel.bottomAnchor.constraint(equalTo: headerStack.topAnchor, constant: -15),
            
            headerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.headerStackLeadingTrailing),
            headerStack.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: Constants.headerStackTop),
            headerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.headerStackLeadingTrailing),
                        
            courseTitle.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            courseTitle.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: Constants.courseTitleTop),
            courseTitle.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
            
            markdownView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            markdownView.topAnchor.constraint(equalTo: courseTitle.bottomAnchor, constant: Constants.markdownViewTop),
            markdownView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            spacerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spacerView.topAnchor.constraint(equalTo: markdownView.bottomAnchor, constant: Constants.videoSectionSpacerTop),
            spacerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
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
            finishButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -Constants.finishButtonBottom),
            
            paidCourseBlockView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            paidCourseBlockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            paidCourseBlockView.topAnchor.constraint(equalTo: spacerView.bottomAnchor),
            paidCourseBlockView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
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
    func display(_ response: VideoCoursePostQuery.Data) {
        guard
            let imageUrl = response.post?.image?.url,
            let tags = response.post?.tags?.compactMap({ $0?.name }),
            let authorName = response.post?.author?.name,
            let authorJobTitle = response.post?.author?.jobTitle,
            let authorPhotoUrl = response.post?.author?.photo?.url,
            let content = response.post?.postTypeDz.first??.asComponentPostTypeVideoCourse?.description,
            let videoList = response.post?.postTypeDz.first??.asComponentPostTypeVideoCourse?.video?.compactMap({ $0 })
        else {
            return
        }
        
        headerImageView.kf.indicatorType = .activity
        headerImageView.kf.setImage(with: URL(string: AppConstants.serverURL + imageUrl))
        
        titleLabel.text = response.post?.title
        tagsStackView.fill(by: tags)
        authorView.fill(by: .author(authorName), jobTitle: authorJobTitle, avatar: authorPhotoUrl)
        
        let webViewSettings = response.webViewSetting?.data ?? ""
        markdownView.load(markdown: fixContentStrapiLinks(content) + webViewSettings, enableImage: true)
        
        self.videoList = videoList

        videoList.forEach {
            videoStack.addArrangedSubview(VideoView(videoId: $0.youtubeLink, title: $0.title))
            
            if !videoList.isLast(element: $0) {
                videoStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .appPurple))
            }
        }
                
        markdownView.onRendered = { [weak self] height in
            self?.hideSpinner()
            self?.markdownView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        let userHasPremium = response.me?.hasPremium ?? false
        let postIsPaid = response.post?.isPaid ?? false
        
        if postIsPaid && !userHasPremium {
            titleLabel.textColor = .white
            paidCourseBlockView.isHidden = false
        } else {
            premiumVideoCourseLabel.isHidden = true
            premiumHeaderBackgroundView.isHidden = true
        }
    }
}

// MARK: - VideoCoursePostQuery/Equatable
extension VideoCoursePostQuery.Data.Post.PostTypeDz.AsComponentPostTypeVideoCourse.Video: Equatable {
    public static func == (lhs: VideoCoursePostQuery.Data.Post.PostTypeDz.AsComponentPostTypeVideoCourse.Video, rhs: VideoCoursePostQuery.Data.Post.PostTypeDz.AsComponentPostTypeVideoCourse.Video) -> Bool {
        lhs.title == rhs.title && lhs.youtubeLink == rhs.youtubeLink
    }
}
