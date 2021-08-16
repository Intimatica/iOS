//
//  CollectionViewCell.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/11/21.
//

import UIKit

class CategoryFilterCollectionViewCell: UICollectionViewCell {
    enum State {
        case normal
        case selected
    }
    
    // MARK: - Properties
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(hex: 0xB38EFF)
        label.font = .rubik(fontSize: .regular, fontWeight: .medium)
        return label
    }()
    
    private lazy var headerView: UIView = {
        let view = SpacerView(height: Constants.headerViewHeight, backgroundColor: .appYellow)
        view.isHidden = true
        return view
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
        
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.red.cgColor
        
        contentView.addSubview(headerView)
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.nameLabelTop),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    // MARK: - Public
    func fill(by name: String) {
        nameLabel.text = name
    }
    
    func setState(_ state: State) {
        switch state {
        case .normal:
            headerView.isHidden = true
        case .selected:
            headerView.isHidden = false
        }
    }
}

// MARK: - Helper/Constants
extension CategoryFilterCollectionViewCell {
    struct Constants {
        static let headerViewHeight: CGFloat = 3
        static let nameLabelTop: CGFloat = 10
    }
}
