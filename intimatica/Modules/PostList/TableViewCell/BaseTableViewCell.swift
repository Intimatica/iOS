//
//  TableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit
import Kingfisher

class BaseTableViewCell: UITableViewCell {
    // MARK: - Properties
    var presenter: PostListPresenterProtocol!
    var post: Post!
    var favorites: Set<String> = []
    
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
    
    lazy var tagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.tagStackViewSpacing
        return stackView
    }()
    
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
    lazy var favoriteButtonView = FavoriteButtonView()
    
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
        
        postLabelView.clear()
        
        backgroundImageView.kf.cancelDownloadTask()
        tagStackView.removeAllArrangedSubviews()
        titleLabel.text = ""
    }
    
    func fill(by post: Post, with favorites: Set<String>, and presenter: PostListPresenterProtocol) {
//        print("Fill \(post.id) \(post.type) with \(favorites)")
        
        self.presenter = presenter
        self.post = post
        self.favorites = favorites
        
        let url = URL(string: AppConstants.serverURL + post.imageUrl)
        backgroundImageView.kf.indicatorType = .activity
        backgroundImageView.kf.setImage(with: url)
        
        titleLabel.text = post.title
        post.tags.forEach {
            tagStackView.addArrangedSubview(addTagView(with: $0))
        }
        
        switch post.type {
        case .story:
            postLabelView.setState(.story)
        case .theory:
            postLabelView.setState(.theory)
        case .video:
            playButtonImageView.isHidden = false
        case .videoCourse:
            postLabelView.setState(post.isPaid ? .premiumVideoCourse : .videoCourse)
//            postLabelView.setState(.videoCourse)
        }
        
        if favorites.contains(post.id) {
            favoriteButtonView.state = .selected
        }
    }
    
    // MARK: - Layout
    func setupView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        selectionStyle = .none
        
        view.addSubview(postView)
        postView.addSubview(backgroundImageView)
        postView.addSubview(postLabelView)
        postView.addSubview(tagStackView)
        postView.addSubview(titleLabel)
    }
    
    func addTagView(with text: String) -> UIView {
        return LabelWithBackground(with: text,
                                   textColor: Constants.tagLabelTextColor,
                                   backgroundColor: Constants.tagBackgroundColor,
                                   font: Constants.tagLabelFont,
                                   verticalSpacing: Constants.tagLabelTopBottom,
                                   horizontalSpacing: Constants.tagLabelLeadingTrailing,
                                   cornerRadius: Constants.tagBorderRadius)
    }
}

// MARK: - Helper/Constants
extension BaseTableViewCell {
    struct Constants {
        static let cellBorderColor = 0xD0B9FF
        static let cellBorderRadius: CGFloat = 20
        
        static let tagLabelFont: UIFont = .rubik(fontSize: .verySmall, fontWeight: .regular)
        static let tagLabelTextColor: UIColor = .appPurple
        static let tagBackgroundColor: UIColor = .init(hex: 0xF2ECFF)
        static let tagBorderRadius: CGFloat = 8
        static let tagLabelTopBottom: CGFloat = 3
        static let tagLabelLeadingTrailing: CGFloat = 5
        
        static let postViewSpacing: CGFloat = 22
        static let postViewLeadingTrailing: CGFloat = 25
        static let backgroundImageViewHeight: CGFloat = 130
        
        static let favoriteButtonViewTopTrailing: CGFloat = 13
        static let postLabelLeading: CGFloat = 13
        
        static let tagStackViewSpacing: CGFloat = 7
        static let tagStackViewHeight: CGFloat = 17
        static let tagStackViewLeadingTrailing: CGFloat = 25
        static let tagStackViewTop: CGFloat = 15
        
        static let titleLabelTop: CGFloat = 6
        static let titleLabelLeadingTrailing: CGFloat = 25
        static let titleLabelBottom: CGFloat = 20
        
        static let playImageViewWidthHeight: CGFloat = 66
    }
}
