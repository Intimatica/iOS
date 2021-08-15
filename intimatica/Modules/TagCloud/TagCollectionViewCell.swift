//
//  TagCollectionViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/12/21.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    enum State {
        case normal, selected
    }
    
    // MARK: - Properties
    var state: State = .normal {
        didSet {
            switch state {
            case .normal:
                contentView.backgroundColor = Constants.contentViewBackgroundColorForNormal
                nameLabel.textColor = .black
            case .selected:
                contentView.backgroundColor = Constants.contentViewBackgroundColorForSelected
                nameLabel.textColor = .white
            }
        }
    }
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .small, fontWeight: .medium)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fillSuperview()
        contentView.backgroundColor = .init(hex: 0xEFF2F6)
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.nameLabelLeadingTrailing),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.nameLabelTopBottom),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.nameLabelLeadingTrailing),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.nameLabelTopBottom)
        ])
    }
    
    // MARK: - Public
    func fill(by name: String) {
        nameLabel.text = name
    }
    
    func toggleState() {
        state = state == .normal ? .selected : .normal
    }
}

// MARK: - Helper/Constraints
extension TagCollectionViewCell {
    struct Constants {
        static let contentViewCornerRadius: CGFloat = 10
        static let nameLabelLeadingTrailing: CGFloat = 14
        static let nameLabelTopBottom: CGFloat = 8
        
        static let contentViewBackgroundColorForNormal: UIColor = .init(hex: 0xEFF2F6)
        static let contentViewBackgroundColorForSelected: UIColor = .init(hex: 0x9764FF)
    }
}
