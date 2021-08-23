//
//  PostLabel.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/5/21.
//

import UIKit

final class PostLabelView: UIStackView {
    enum State {
        case story
        case theory
        case video
        case videoCourse
        case premiumVideoCourse
    }
    
    // MARK: - Properties
    var state: State! {
        didSet {
            textLabel.isHidden = true
            premiumVideoCourseLabel.isHidden = true

            switch state {
            case .story:
                textLabel.label.text = L10n("TABLE_CELL_POST_LABEL_STORY")
                textLabel.backgroundColor = Constants.storyBackgroupndColor
                textLabel.isHidden = false
            case .theory:
                textLabel.label.text = L10n("TABLE_CELL_POST_LABEL_THEORY")
                textLabel.backgroundColor = Constants.theoryBackgroupndColor
                textLabel.isHidden = false
            case .video:
                break;
            case .videoCourse:
                textLabel.label.text = L10n("TABLE_CELL_POST_LABEL_COURSE")
                textLabel.backgroundColor = Constants.videoCourseBackgroupndColor
                textLabel.isHidden = false
            case .premiumVideoCourse:
                premiumVideoCourseLabel.isHidden = false
                
            // QUESTION
            case .none:
                break;
            }
        }
    }
    
    private lazy var textLabel = LabelWithBackground(with: "",
                                    textColor: .white,
                                    backgroundColor: Constants.storyBackgroupndColor,
                                    font: .rubik(fontSize: .small, fontWeight: .medium),
                                    verticalSpacing: Constants.verticalSpacing,
                                    horizontalSpacing: Constants.horizontalSpacing)
    
    private lazy var premiumVideoCourseLabel = PremiumCourseLabel()
    
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        spacing = 0

        addArrangedSubview(textLabel)
        addArrangedSubview(premiumVideoCourseLabel)
    }
}

// MARK: - Constants/Helper
extension PostLabelView {
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
