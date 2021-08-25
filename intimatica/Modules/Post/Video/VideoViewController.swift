//
//  VideoViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/2/21.
//

import UIKit
import youtube_ios_player_helper

class VideoViewController: BasePostViewController {
    // MARK: - Properties
    private let presenter: VideoPresenterProtocol
    
    private lazy var playerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var playImageView: UIImageView = {
        let image = UIImage(named: "play")
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var videoPlayer: YTPlayerView = {
        let player = YTPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    
    // MARK: - Initializers
    init(presenter: VideoPresenterProtocol) {
        self.presenter = presenter
        
        super.init(presenter: presenter, rightBarButtonType: .favorite)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        
        presenter.viewDidLoad()
    }
    
    // MARK: - Layout
    func setupView() {
        contentView.addSubview(headerStack)
        contentView.addSubview(markdownView)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(tagsStackView)
        headerStack.addArrangedSubview(SpacerView(height: 10, backgroundColor: .clear))
        headerStack.addArrangedSubview(playerView)
        
        playerView.addSubview(videoPlayer)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.headerStackLeadingTrailing),
            headerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.headerStackTop),
            headerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.headerStackLeadingTrailing),
            
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9/16),
            videoPlayer.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            videoPlayer.topAnchor.constraint(equalTo: playerView.topAnchor),
            videoPlayer.trailingAnchor.constraint(equalTo: playerView.trailingAnchor),
            videoPlayer.bottomAnchor.constraint(equalTo: playerView.bottomAnchor),
            
            markdownView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            markdownView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: Constants.markdownViewTopToPlayerView),
            markdownView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            markdownView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

// MARK: - VideoViewProtocol
extension VideoViewController: VideoViewProtocol {
    func display(_ post: VideoPostQuery.Data.Post) {
        guard
//            let imageUrl = post.image?.url,
            let tags = post.tags?.compactMap({ $0?.name })
        else {
            return
        }
        
        titleLabel.text = post.title
        tagsStackView.fill(by: tags)
        
//        headerImageView.kf.indicatorType = .activity
//        headerImageView.kf.setImage(with: URL(string: AppConstants.serverURL + imageUrl))
        
        let playvarsDic = ["controls": 0,
                           "playsinline": 0,
                           "autohide": 1,
                           "showinfo": 0,
                           "autoplay": 1,
                           "cc_load_policy": 0, // Hide closed captions
                           "iv_load_policy": 3, // Hide the Video Annotations
                           "modestbranding": 0]
        videoPlayer.load(withVideoId: "VkrDAvPRdDw", playerVars: playvarsDic)
        videoPlayer.playVideo()
        
        markdownView.load(markdown: post.postTypeDz.first??.asComponentPostTypeVideo?.description)

        markdownView.onRendered = { [weak self] height in
            self?.hideSpinner()
        }
    }
}

// MARK: -Helper/Constants
extension VideoViewController.Constants {
    static let playImageViewHeightWidth: CGFloat = 80
    static let markdownViewTopToPlayerView: CGFloat = 30
}
