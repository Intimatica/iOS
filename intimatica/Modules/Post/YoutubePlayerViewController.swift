//
//  YoutubePlayerViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/3/21.
//

import UIKit
import YouTubePlayer
import youtube_ios_player_helper

class YoutubePlayerViewController: UIViewController {
    // MARK: - Properties
//    var videoPlayer: YouTubePlayerView = {
//        let player = YouTubePlayerView()
//        player.translatesAutoresizingMaskIntoConstraints = false
//        let vars = ["controls": 1 as AnyObject,
//                           "playsinline": 0 as AnyObject,
//                           "autohide": 1 as AnyObject,
//                           "showinfo": 1 as AnyObject,
//                           "autoplay": 1 as AnyObject,
//                           "modestbranding": 1 as AnyObject]
//        player.playerVars = vars
//        return player
//    }()
  
    private lazy var videoPlayer: YTPlayerView = {
        let player = YTPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        
        let playvarsDic = ["controls": 0, "playsinline": 0, "autohide": 1, "showinfo": 0, "autoplay": 1, "modestbranding": 0]
        videoPlayer.load(withVideoId: "VkrDAvPRdDw", playerVars: playvarsDic)
        videoPlayer.playVideo(at: 60)
        
//        let myVideoURL = URL(string: "https://www.youtube.com/watch?v=VkrDAvPRdDw")
//        videoPlayer.loadVideoURL(myVideoURL!)
//        videoPlayer.play()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(videoPlayer)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            videoPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            videoPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
