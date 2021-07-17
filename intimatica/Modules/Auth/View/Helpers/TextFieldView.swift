//
//  TextFieldViewF.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/16/21.
//

import UIKit

struct TextFieldViewFieldSettings {
    var placeholder: String
    var returnKeyType: UIReturnKeyType
    
    static func settings(placeholder: String = "", returnKeyType: UIReturnKeyType = .done) -> TextFieldViewFieldSettings {
        .init(placeholder: placeholder, returnKeyType: returnKeyType)
    }
}

enum TextFieldViewField {
    case email(TextFieldViewFieldSettings)
    case password(TextFieldViewFieldSettings)
}

protocol TextFieldViewDelegate {
    func textFieldShouldReturn(_ textFieldView: TextFieldView)
}

final class TextFieldView: UIView {
    // MARK: - Properties
    var textField: UITextField!
    lazy var spacer = createSpacer()
    var delegate: TextFieldViewDelegate?
    
    // MARK: - Initializers
    init(field: TextFieldViewField) {
        super.init(frame: .zero)
        
        setupTextField(field: field)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField(field: TextFieldViewField) {
        switch field {
        
        case .email(let settings):
            textField = createEmailField(from: settings)
        
        case .password(let settings):
            textField = createPasswordField(from: settings)
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
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeigh),
            
            spacer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spacer.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constants.spacerTop),
            spacer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spacer.heightAnchor.constraint(equalToConstant: Constants.spacerHeight)
        ])
    }
}

// MARK: - Helpers/Contraints
extension TextFieldView {
    private struct Constants {
        static let textFieldHeigh: CGFloat = 25
        static let spacerHeight: CGFloat = 1
        static let spacerTop: CGFloat = 8
    }
}

// MARK: - Helpers/UIFileds
extension TextFieldView {

    func createEmailField(from settings: TextFieldViewFieldSettings) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = settings.placeholder
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.returnKeyType = settings.returnKeyType
        textField.becomeFirstResponder()
        return textField
    }
    
    func createPasswordField(from settings: TextFieldViewFieldSettings) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = settings.placeholder
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.returnKeyType = settings.returnKeyType
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldReturn(self)
        return true
    }
}
