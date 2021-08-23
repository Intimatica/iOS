//
//  TagStackView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/21/21.
//

import UIKit

class StoryTagStackView: UIStackView {
    enum TagType {
        case nonPublic
        case published
        case underConsideration
    }
    
    // MARK: - Properties
    private lazy var privateLabel = LabelWithBackground(with: L10n("TAG_LABEL_PRIVATE"),
                                                             textColor: .init(hex: 0xDC275E),
                                                             backgroundColor: .init(hex: 0xFFC1D4),
                                                             font: Constants.tagFont,
                                                             verticalSpacing: Constants.tagLabelTopBottom,
                                                             horizontalSpacing: Constants.tagLabelLeadingTrailing)
    
    private lazy var underConsiderationLabel = LabelWithBackground(with: L10n("TAG_LABEL_UNDER_CONSIDERATION"),
                                                             textColor: .init(hex: 0x866000),
                                                             backgroundColor: .init(hex: 0xFFE485),
                                                             font: Constants.tagFont,
                                                             verticalSpacing: Constants.tagLabelTopBottom,
                                                             horizontalSpacing: Constants.tagLabelLeadingTrailing)
    
    private lazy var publishedLabel = LabelWithBackground(with: L10n("TAG_LABEL_PUBLISHED"),
                                                             textColor: .init(hex: 0x077B44),
                                                             backgroundColor: .init(hex: 0xA7F2CE),
                                                             font: Constants.tagFont,
                                                             verticalSpacing: Constants.tagLabelTopBottom,
                                                             horizontalSpacing: Constants.tagLabelLeadingTrailing)
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        spacing = Constants.spacing
        
        addArrangedSubview(privateLabel)
        addArrangedSubview(underConsiderationLabel)
        addArrangedSubview(publishedLabel)
        addArrangedSubview(UIView())
        
        clear()
    }
    
    // MARK: - Public
    func add(_ type: TagType) {
        switch type {
        case .nonPublic:
            privateLabel.isHidden = false
        case .underConsideration:
            underConsiderationLabel.isHidden = false
        case .published:
            publishedLabel.isHidden = false
        }
    }
    
    func clear() {
        privateLabel.isHidden = true
        underConsiderationLabel.isHidden = true
        publishedLabel.isHidden = true
    }
}

// MARK: - Helper/Constants
extension StoryTagStackView {
    struct Constants {
        static let tagFont: UIFont = .rubik(fontSize: .verySmall, fontWeight: .medium)
        static let spacing: CGFloat = 5
        static let tagLabelTopBottom: CGFloat = 3
        static let tagLabelLeadingTrailing: CGFloat = 8
    }
}
