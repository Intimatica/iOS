//
//  TableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/6/21.
//

import UIKit
import youtube_ios_player_helper

final class TableViewCell: UITableViewCell {
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
        label.font = .rubik(fontSize: .regular, fontWeight: .medium)
        label.numberOfLines = 5
        return label
    }()
    
    private var spacerView = SpacerView(height: 1, backgroundColor: .appPurple)
    
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        selectionStyle = .none
        
        view.addSubview(videoPlayerView)
        view.addSubview(title)
        view.addSubview(spacerView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            videoPlayerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            videoPlayerView.heightAnchor.constraint(equalTo: videoPlayerView.widthAnchor, multiplier: 9/16),
            
            title.leadingAnchor.constraint(equalTo: videoPlayerView.leadingAnchor),
            title.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: videoPlayerView.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    // MARK: - Public
    func fill(by video: VideoCoursePostQuery.Data.Post.PostType.AsComponentPostTypeVideoCourse.Video) {
        videoPlayerView.load(withVideoId: video.youtubeLink)
        title.text = video.title
    }
}
