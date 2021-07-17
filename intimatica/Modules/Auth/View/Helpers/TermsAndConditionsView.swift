//
//  TermAndConditionsView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import UIKit

final class TermsAndConditionsView: UIView {

    // MARK: - Properties
    private lazy var radioButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "radio_button"), for: .normal)
        button.setImage(UIImage(named: "radio_button_selected"), for: .selected)
        button.addAction {
            button.isSelected = button.isSelected ? false : true
        }
        
        return button
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Я согласна (ен) с Условиями использования"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(radioButton)
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            radioButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            radioButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constraints.radioButtonTopButtom),
            radioButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constraints.radioButtonTopButtom),
            radioButton.widthAnchor.constraint(equalTo: radioButton.heightAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: Constraints.textLabelLeading),
            textLabel.topAnchor.constraint(equalTo: view.topAnchor),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - Helper/Constraints
extension TermsAndConditionsView {
    private struct Constraints {
        static let radioButtonTopButtom: CGFloat = 5
        static let textLabelLeading: CGFloat = 14
    }
}
