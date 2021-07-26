//
//  TableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    // MARK: - Properties
    private lazy var postView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.init(hex: Constants.cellBorderColor).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = Constants.cellBorderRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .regular, fontWeight: .regular)
        label.numberOfLines = 4
        return label
    }()
    
    private lazy var tagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.tagStackViewSpacing
        return stackView
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
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill(by post: Post) {
        let image = UIImage(named: post.imageName)
        postImageView.image = image
        titleLabel.text = post.title
        post.tags.forEach {
            tagStackView.addArrangedSubview(TagView(with: $0))
        }
    }
    
    
    // MARK: - Layout
    private func setupView() {
        backgroundColor = .clear
        
        view.addSubview(postView)
        postView.addSubview(postImageView)
        postView.addSubview(tagStackView)
        postView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.postViewLeadingTrailing),
            postView.topAnchor.constraint(equalTo: view.topAnchor),
            postView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.postViewLeadingTrailing),
            postView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.postViewSpacing),
            
            postImageView.leadingAnchor.constraint(equalTo: postView.leadingAnchor),
            postImageView.topAnchor.constraint(equalTo: postView.topAnchor),
            postImageView.trailingAnchor.constraint(equalTo: postView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: Constants.postImageViewHeight),
            
            tagStackView.heightAnchor.constraint(equalToConstant: Constants.tagStackViewHeight),
            tagStackView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: Constants.tagStackViewLeadingTrailing),
            tagStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: Constants.tagStackViewTop),
            tagStackView.trailingAnchor.constraint(lessThanOrEqualTo: postView.trailingAnchor, constant: -Constants.tagStackViewLeadingTrailing),
            
            titleLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: Constants.titleLabelLeadingTrailing),
            titleLabel.topAnchor.constraint(equalTo: tagStackView.bottomAnchor, constant: Constants.titleLabelTop),
            titleLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -Constants.titleLabelLeadingTrailing),
            titleLabel.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -Constants.titleLabelBottom)
        ])
    }
}

// MARK: - Helper/Constants
extension TableViewCell {
    struct Constants {
        static let cellBorderColor = 0xD0B9FF
        static let cellBorderRadius: CGFloat = 20
        
        static let postViewSpacing: CGFloat = 22
        static let postViewLeadingTrailing: CGFloat = 0
        static let postImageViewHeight: CGFloat = 130
        
        static let tagStackViewSpacing: CGFloat = 7
        static let tagStackViewHeight: CGFloat = 17
        static let tagStackViewLeadingTrailing: CGFloat = 25
        static let tagStackViewTop: CGFloat = 15
        
        static let titleLabelTop: CGFloat = 6
        static let titleLabelLeadingTrailing: CGFloat = 25
        static let titleLabelBottom: CGFloat = 20
    }
}
