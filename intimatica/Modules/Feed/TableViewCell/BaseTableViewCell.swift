//
//  TableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit
import Kingfisher

protocol BaseTableViewCellDelegate: AnyObject {
    func addToFavorites(by indexPath: IndexPath)
    func removeFromFavorites(by indexPath: IndexPath)
}

class BaseTableViewCell: UITableViewCell {
    // MARK: - Properties
    var post: Post!
    var indexPath: IndexPath!
    weak var delegate: BaseTableViewCellDelegate?
    
    lazy var postView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.init(hex: Constants.cellBorderColor).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = Constants.cellBorderRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .regular, fontWeight: .regular)
        label.numberOfLines = 4
        return label
    }()
    
    lazy var tagStackView = TagStackView()
    
    lazy var playButtonImageView: UIImageView = {
        let image = UIImage(named: "play")
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        return imageView
    }()
    
    lazy var postLabelView = PostLabelView()
        
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundImageView.kf.cancelDownloadTask()
        titleLabel.text = ""
    }
    
    // MARK: - Layout
    func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(postView)
        postView.addSubview(backgroundImageView)
        postView.addSubview(postLabelView)
        postView.addSubview(tagStackView)
        postView.addSubview(titleLabel)
    }
    
    // MARK: - Public
    func fill(by post: Post, isFavorite: Bool = false, indexPath: IndexPath, delegate: BaseTableViewCellDelegate?) {
//        print("Fill \(post.id) \(post.type) with \(favorites)")
        
        self.post = post
        self.indexPath = indexPath
        self.delegate = delegate
        
        let url = URL(string: AppConstants.serverURL + post.imageUrl)
        backgroundImageView.kf.indicatorType = .activity
        backgroundImageView.kf.setImage(with: url)
        
        titleLabel.text = post.title
        tagStackView.fill(by: post.tags)
        
        switch post.type {
        case .story:
            postLabelView.state = .story
        case .theory:
            postLabelView.state = .theory
        case .video:
            postLabelView.state = .video
        case .videoCourse:
            postLabelView.state = post.isPaid ? .premiumVideoCourse : .videoCourse
        }
    }
}

// MARK: - Helper/Constants
extension BaseTableViewCell {
    struct Constants {
        static let cellBorderColor = 0xD0B9FF
        static let cellBorderRadius: CGFloat = 20

        static let postViewSpacing: CGFloat = 15
        static let postViewLeadingTrailing: CGFloat = 15
        static let backgroundImageViewHeight: CGFloat = 130
        
        static let favoriteButtonViewTopTrailing: CGFloat = 13
        static let postLabelLeading: CGFloat = 13
        
        static let tagStackViewHeight: CGFloat = 17
        static let tagStackViewLeadingTrailing: CGFloat = 25
        static let tagStackViewTop: CGFloat = 15
        
        static let titleLabelTop: CGFloat = 6
        static let titleLabelLeadingTrailing: CGFloat = 25
        static let titleLabelBottom: CGFloat = 20
        
        static let playImageViewWidthHeight: CGFloat = 66
    }
}
