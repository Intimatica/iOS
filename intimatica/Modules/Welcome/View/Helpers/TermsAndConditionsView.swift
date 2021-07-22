//
//  TermsAndConditionsView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/22/21.
//

import UIKit

class TermsAndConditionsView: UIView {

    // MARK: - Properties
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "radio_button"), for: .normal)
        button.setImage(UIImage(named: "radio_button_selected"), for: .selected)
        return button
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .rubik(fontSize: .small, fontWeight: .regular)
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Initializers
    init(with labelText: String) {
        super.init(frame: .zero)
        
        label.text = labelText
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(button)
        addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.buttonTopButtom),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.buttonTopButtom),
            
            label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: Constants.labelLeading),
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension TermsAndConditionsView {
    private struct Constants {
        static let buttonTopButtom: CGFloat = 2
        static let labelLeading: CGFloat = 15
    }
}
