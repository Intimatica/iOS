//
//  NotificationTableViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/14/21.
//

import UIKit
import Kingfisher
import SnapKit
import LocalizedTimeAgo

class NotificationTableViewCell: UITableViewCell {
    // MARK: - Properties
    private lazy var notificationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    
    private lazy var textContainerView = UIView()
    private lazy var dateLabel = UILabel(font: .rubik(fontSize: .small, fontWeight: .regular), textColor: .appDarkGray, text: "")
    private lazy var notificationLabel = NotificationLabelView()
    private lazy var titleLabel = UILabel(font: .rubik(fontSize: .regular, fontWeight: .regular))
    private lazy var spacerView = SpacerView(height: 1, backgroundColor: .appPalePurple)
    private lazy var greenCirleView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: 0x16D31E)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 9 / 2
        view.isHidden = true
        return view
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
    override func prepareForReuse() {
        super.prepareForReuse()
        
        notificationImageView.kf.cancelDownloadTask()
        dateLabel.text = " "
        titleLabel.text = " "
        greenCirleView.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // QUESTION: why doesn't work
        
//        if greenCirleView.layer.cornerRadius != greenCirleView.bounds.height / 2 {
//            greenCirleView.layer.cornerRadius = greenCirleView.bounds.height / 2
//        }
    }
    
    // MARK: - Layout
    private func setupView() {
        selectionStyle = .none
        
        contentView.addSubview(spacerView)
        contentView.addSubview(notificationImageView)
        contentView.addSubview(textContainerView)
        contentView.addSubview(greenCirleView)
        textContainerView.addSubview(dateLabel)
        textContainerView.addSubview(notificationLabel)
        textContainerView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        spacerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(contentView)
        }
        
        greenCirleView.snp.makeConstraints { make in
            make.width.height.equalTo(9)
            make.top.equalTo(contentView).offset(23)
            make.trailing.equalTo(contentView).offset(-16)
        }
        
        notificationImageView.snp.makeConstraints { make in
            make.width.equalTo(Constansts.notificationImageViewWidth)
            make.height.equalTo(Constansts.notificationImageViewHeight)
            make.leading.equalTo(contentView).offset(Constansts.notificationImageViewLeading)
            make.top.equalTo(textContainerView)
//            make.bottom.greaterThanOrEqualTo(contentView.snp.bottom).offset(-Constansts.textContainerViewTopBottom)
        }
        
        textContainerView.snp.makeConstraints { make in
            make.leading.equalTo(notificationImageView.snp.trailing).offset(Constansts.textContainerViewLeadingTrailing)
            make.top.equalTo(contentView).inset(Constansts.textContainerViewTopBottom)
            make.trailing.equalTo(contentView).inset(Constansts.textContainerViewLeadingTrailing)
            make.bottom.equalTo(contentView.snp.bottom).offset(-Constansts.textContainerViewTopBottom)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(textContainerView)
        }
        
        notificationLabel.snp.makeConstraints { make in
            make.leading.equalTo(textContainerView)
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(textContainerView)
            make.top.equalTo(notificationLabel.snp.bottom).offset(10)
        }
    }
    
    // MARK: - Public
    func fill(by post: NotificationsQuery.Data.PostNotification, isViewed: Bool) {
        if !isViewed {
            greenCirleView.isHidden = false
        }
        
        if let previewUrl = post.image?.url {
            let url = URL(string: AppConstants.serverURL + previewUrl)
            notificationImageView.kf.indicatorType = .activity
            notificationImageView.kf.setImage(with: url)
        } else {
            // TODO: add placeholder
        }
        
        dateLabel.text = post.publishedAt
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"

        if let publishedAt = post.publishedAt, let date = dateFormatter.date(from: publishedAt) {
            dateLabel.text = date.timeAgo(numericDates: false, numericTimes: false)
        }
        
        titleLabel.text = post.title
        
        if let postTypeName = post.postType?.name {
            switch postTypeName {
            case "Theory":
                notificationLabel.state = .theory
            case "Story":
                notificationLabel.state = .story
            case "Video":
                notificationLabel.state = .video
            case "Course":
                notificationLabel.state = post.isPaid ? .premiumVideoCourse : .videoCourse
            default:
                print("\(postTypeName) not implemented")
            }
        }
    }
}

// MARK: - Helper/Constants
extension NotificationTableViewCell {
    struct Constansts {
        static let notificationImageViewHeight: CGFloat = 93
        static let notificationImageViewWidth: CGFloat = 100
        static let notificationImageViewLeading: CGFloat = 15
        static let textContainerViewTopBottom: CGFloat = 25
        static let textContainerViewLeadingTrailing: CGFloat = 15
    }
}
