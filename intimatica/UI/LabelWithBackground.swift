//
//  TagView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

class LabelWithBackground: UIView {
    // MARK: - Properties
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik()
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Initializers
    init(with text: String = "", textColor: UIColor = .black, backgroundColor: UIColor = .lightGray, font: UIFont = .rubik(), verticalSpacing: CGFloat = 3, horizontalSpacing: CGFloat = 10, cornerRadius: CGFloat = 10) {
        super.init(frame: .zero)
        
        setupLabel(text: text, color: textColor, font: font)
        setupView(backgroundColor: backgroundColor, cornerRadius: cornerRadius)
        setupConstraints(verticalSpacing: verticalSpacing, horizontalSpacing: horizontalSpacing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupLabel(text: String, color: UIColor, font: UIFont) {
        label.text = text
        label.textColor = color
        label.font = font
    }
    
    private func setupView(backgroundColor: UIColor, cornerRadius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true

        addSubview(label)
    }
    
    private func setupConstraints(verticalSpacing: CGFloat, horizontalSpacing: CGFloat) {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalSpacing),
            label.topAnchor.constraint(equalTo: topAnchor, constant: verticalSpacing),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalSpacing),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalSpacing)
        ])
    }
}
