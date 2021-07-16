//
//  TextFieldViewF.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/16/21.
//

import UIKit

enum TextFieldViewField {
    case email
    case password
}

final class TextFieldView: UIView {
    // MARK: - Properties
    var textField: UITextField!
    lazy var spacer = createSpacer()
    
    // MARK: - Initializers
    init(field: TextFieldViewField, placeholder: String) {
        super.init(frame: .zero)
        
        setupTextField(field: field, placeholder: placeholder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField(field: TextFieldViewField, placeholder: String) {
        switch field {
        
        case .email:
            textField = createEmailField(placeholder: placeholder)
        
        case .password:
            textField = createPasswordField(placeholder: placeholder)
        }
        
        textField.delegate = self
    }
    
    // MARK: - Layout
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textField)
        addSubview(spacer)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.topAnchor.constraint(equalTo: view.topAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 25),
            
            spacer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spacer.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            spacer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spacer.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

// MARK: - Helpers
extension TextFieldView {

    func createEmailField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.becomeFirstResponder()
        return textField
    }
    
    func createPasswordField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.textContentType = .password
        textField.returnKeyType = .next
        return textField
    }
    
     func createSpacer() -> UIView {
        let progress = UIView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = .appLightPuple
        return progress
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        spacer.backgroundColor = .appPurple
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        spacer.backgroundColor = .appLightPuple
    }
}
