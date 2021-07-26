//
//  TagView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

class TagView: UIView {
    // MARK: - Properties
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .verySmall, fontWeight: .regular)
        label.textColor = .appPurple
        return label
    }()
    
    // MARK: - Initializers
    init(with text: String) {
        super.init(frame: .zero)
        
        tagLabel.text = text
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(hex: Constants.backgroundColor)
        view.layer.cornerRadius = Constants.borderRadius
        view.layer.masksToBounds = true
        
        view.addSubview(tagLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tagLabelLeadingTrailing),
            tagLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.tagLabelTopBottom),
            tagLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.tagLabelLeadingTrailing),
            tagLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.tagLabelTopBottom)
        ])
    }
}


// MARK: - Helper/Constants
extension TagView {
    struct Constants {
        static let backgroundColor = 0xF2ECFF
        static let borderRadius: CGFloat = 10
        
        static let tagLabelTopBottom: CGFloat = 3
        static let tagLabelLeadingTrailing: CGFloat = 5
    }
}
