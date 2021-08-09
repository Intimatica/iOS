//
//  VideoView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/6/21.
//

import UIKit
import youtube_ios_player_helper

final class VideoView: UIView {
    // MARK: - Properties
    var videoPlayerView: YTPlayerView = {
        let player = YTPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        player.layer.cornerRadius = 20
        player.layer.masksToBounds = true
        return player
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .regular, fontWeight: .regular)
        label.numberOfLines = 5
        return label
    }()
    
    // MARK: - Initializers
    init(videoId: String, title: String) {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
        
        videoPlayerView.load(withVideoId: videoId)
        self.title.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        view.addSubview(videoPlayerView)
        view.addSubview(title)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoPlayerView.topAnchor.constraint(equalTo: view.topAnchor),
            videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoPlayerView.heightAnchor.constraint(equalTo: videoPlayerView.widthAnchor, multiplier: Constants.videoPlayerViewRatio),
            
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            title.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: Constants.titleTop),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Helper/Constants
extension VideoView {
    struct Constants {
        static let videoPlayerViewRatio: CGFloat = 9/16
        static let titleTop: CGFloat = 20
    }
}
