//
//  TagStackView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/17/21.
//

import UIKit

class TagStackView: UIStackView {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        spacing = Constants.spacing
    }
    
    // MARK: - Public
    func fill(by tags: [String]) {
        clear()
        
        tags.forEach { tag in
            addArrangedSubview(addTagView(with: tag))
        }
        
        addArrangedSubview(UIView())
    }
    
    func clear() {
        removeAllArrangedSubviews()
    }
    
    // MARK: - Private
    func addTagView(with text: String) -> UIView {
        return LabelWithBackground(with: text,
                                   textColor: Constants.tagLabelTextColor,
                                   backgroundColor: Constants.tagBackgroundColor,
                                   font: Constants.tagLabelFont,
                                   verticalSpacing: Constants.tagLabelTopBottom,
                                   horizontalSpacing: Constants.tagLabelLeadingTrailing)
    }
}

extension TagStackView {
    struct Constants {
        static let spacing: CGFloat = 7
        
        static let tagLabelFont: UIFont = .rubik(fontSize: .small, fontWeight: .regular)
        static let tagLabelTextColor: UIColor = .appPurple
        static let tagBackgroundColor: UIColor = .init(hex: 0xF2ECFF)
        static let tagLabelTopBottom: CGFloat = 3
        static let tagLabelLeadingTrailing: CGFloat = 8
    }
}
