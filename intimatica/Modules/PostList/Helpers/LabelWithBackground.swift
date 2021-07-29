//
//  TagView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

class LabelWithBackground: UIView {
    // MARK: - Properties
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik()
        label.textColor = .black
        return label
    }()
    
    // MARK: - Initializers
    init(with text: String, textColor: UIColor = .black, backgroundColor: UIColor = .lightGray, font: UIFont = .rubik(), verticalSpacing: CGFloat = 3, horizontalSpacing: CGFloat = 10, cornerRadius: CGFloat = 10) {
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true

        view.addSubview(label)
    }
    
    private func setupConstraints(verticalSpacing: CGFloat, horizontalSpacing: CGFloat) {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalSpacing),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: verticalSpacing),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalSpacing),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalSpacing)
        ])
    }
}
