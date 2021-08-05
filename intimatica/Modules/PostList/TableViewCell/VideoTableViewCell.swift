//
//  VideoTableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import UIKit

class VideoTableViewCell: BaseTableViewCell {
    // MARK: - Propeties
    private lazy var playImageView: UIImageView = {
        let image = UIImage(named: "play")
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lauout
    override func setupView() {
        super.setupView()
        
        postView.addSubview(playImageView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            playImageView.heightAnchor.constraint(equalToConstant: Constants.playImageViewWidthHeight),
            playImageView.widthAnchor.constraint(equalToConstant: Constants.playImageViewWidthHeight),
            playImageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            playImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor)
        ])
    }
}

// MARK: - Constants/Helpers
extension VideoTableViewCell {
    struct Constants {
        static let playImageViewWidthHeight: CGFloat = 66
    }
}
