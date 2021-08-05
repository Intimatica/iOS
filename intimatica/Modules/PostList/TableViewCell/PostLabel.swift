//
//  PostLabel.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/5/21.
//

import UIKit

final class PostLabel: UIView {
    enum State {
        case story
        case theory
        case video
        case videoCourse
        case premiumVideoCourse
    }
    
    // MARK: - Properties
    private weak var activeLabel: UIView?
    
    private lazy var storyLabel = LabelWithBackground(with: L10n("TABLE_CELL_POST_LABEL_STORY"),
                                    textColor: .white,
                                    backgroundColor: Constants.storyBackgroupndColor,
                                    font: .rubik(fontSize: .small),
                                    verticalSpacing: Constants.verticalSpacing,
                                    horizontalSpacing: Constants.horizontalSpacing,
                                    cornerRadius: Constants.cornderRadius)
    
    private lazy var theoryLabel = LabelWithBackground(with: L10n("TABLE_CELL_POST_LABEL_THEORY"),
                                    textColor: .white,
                                    backgroundColor: Constants.theoryBackgroupndColor,
                                    font: .rubik(fontSize: .small),
                                    verticalSpacing: Constants.verticalSpacing,
                                    horizontalSpacing: Constants.horizontalSpacing,
                                    cornerRadius: Constants.cornderRadius)
    
    private lazy var videoCourseLabel = LabelWithBackground(with: L10n("TABLE_CELL_POST_LABEL_COURSE"),
                                    textColor: .white,
                                    backgroundColor: Constants.videoCourseBackgroupndColor,
                                    font: .rubik(fontSize: .small),
                                    verticalSpacing: Constants.verticalSpacing,
                                    horizontalSpacing: Constants.horizontalSpacing,
                                    cornerRadius: Constants.cornderRadius)
    
    private lazy var premiumVideoCourseLabel: UIView  = {
        let labelView = LabelWithBackground(with: L10n("TABLE_CELL_POST_LABEL_PRIMIUM_COURSE"),
                                    textColor: .init(hex: 0xFFE70D),
                                    backgroundColor: Constants.premiumVideoCourseBackgroupndColor,
                                    font: .rubik(fontSize: .small),
                                    verticalSpacing: Constants.verticalSpacing,
                                    horizontalSpacing: Constants.horizontalSpacing,
                                    cornerRadius: Constants.cornderRadius)
        
        labelView.addSubview(starImageView)
        
        NSLayoutConstraint.activate([
            starImageView.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: Constants.horizontalSpacing),
            starImageView.topAnchor.constraint(equalTo: labelView.topAnchor, constant: Constants.verticalSpacing),
            starImageView.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: Constants.verticalSpacing),
            starImageView.widthAnchor.constraint(equalTo: starImageView.heightAnchor),
            
            labelView.label.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 5)
        ])
        
        return labelView
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "star")
        return imageView
    }()
    
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView(_ labelView: UIView?) {
        guard let labelView = labelView else { return }
        
        addSubview(labelView)
        
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelView.topAnchor.constraint(equalTo: topAnchor),
            labelView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        layoutIfNeeded()
        updateConstraintsIfNeeded()
    }
    
    // MARK: - Public
    func setState(_ state: State) {
        clear()
        
        switch state {
        case .story:
            activeLabel = storyLabel
        case .theory:
            activeLabel = theoryLabel
        case .video:
            return
        case .videoCourse:
            activeLabel = videoCourseLabel
        case .premiumVideoCourse:
            activeLabel = premiumVideoCourseLabel
        }
        
        setupView(activeLabel)
    }
    
    func clear() {
        guard let label = activeLabel else { return }
        
        label.removeConstraints(label.constraints)
        label.removeFromSuperview()
    }
}

// MARK: - Constants/Helper
extension PostLabel {
    struct Constants {
        static let storyBackgroupndColor: UIColor = .init(hex: 0xF9477D)
        static let theoryBackgroupndColor: UIColor = .init(hex: 0xFF9900)
        static let videoCourseBackgroupndColor: UIColor = .appPurple
        static let premiumVideoCourseBackgroupndColor: UIColor = .black
        
        static let verticalSpacing: CGFloat = 3
        static let horizontalSpacing: CGFloat = 8
        static let cornderRadius: CGFloat = 10
    }
}
