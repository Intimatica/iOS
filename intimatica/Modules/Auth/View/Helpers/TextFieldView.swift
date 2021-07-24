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
    case nickname(TextFieldViewFieldSettings)
}

protocol TextFieldViewDelegate {
    func textFieldEndEditing(_ textFieldView: TextFieldView)
    func textFieldShouldReturn(_ textFieldView: TextFieldView)
}

final class TextFieldView: UIView {
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    lazy var fieldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " " // space for avoding collaple label
        label.textColor = .appGray
        label.font = .rubik(fontSize: .small, fontWeight: .regular)
        return label
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .appRed
        label.font = .rubik(fontSize: .small, fontWeight: .regular)
        label.isHidden = true
        return label
    }()
    
    lazy var eyeButton: EyeButton = {
        let button = EyeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction { [weak self] in
            self?.eyeButtonDidTap()
        }
        return button
    }()
    
    var textField: UITextField!
    lazy var spacer = createSpacer()
    var delegate: TextFieldViewDelegate?
    
    // MARK: - Initializers
    init(field: TextFieldViewField) {
        super.init(frame: .zero)
        
        setupTextField(field: field)
        setupUI(field: field)
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
            
        case .nickname(let settings):
            textField = createNicknameField(from: settings)
        }
        
        
        
        textField.delegate = self
    }
    
    // MARK: - Layout
    private func setupUI(field: TextFieldViewField) {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(fieldLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(errorLabel)
  
        NSLayoutConstraint.activate([
            spacer.heightAnchor.constraint(equalToConstant: Constants.spacerHeight),
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeigh),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if case .password(_) = field {
            addEyeButton()
        }
    }

    func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        spacer.backgroundColor = .appRed
    }
    
    func hideError() {
        errorLabel.isHidden = true
        spacer.backgroundColor = .appGray
    }
    
    private func addEyeButton() {
        view.addSubview(eyeButton)
        
        NSLayoutConstraint.activate([
            eyeButton.topAnchor.constraint(equalTo: textField.topAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            eyeButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            eyeButton.widthAnchor.constraint(equalTo: eyeButton.heightAnchor)
        ])
    }
    
    private func eyeButtonDidTap() {
        guard let _ = textField.text?.isEmpty else {
            return
        }
        
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        eyeButton.toggleSecure()
    }
}

// MARK: - Helpers/Contraints
extension TextFieldView {
    private struct Constants {
        static let stackViewSpacing: CGFloat = 8
        static let textFieldHeigh: CGFloat = 25
        static let spacerHeight: CGFloat = 1
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
        textField.spellCheckingType = .no
        textField.autocapitalizationType = .none
        textField.text = "a@key42.net"
        return textField
    }
    
    func createPasswordField(from settings: TextFieldViewFieldSettings) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = settings.placeholder
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.returnKeyType = settings.returnKeyType
        textField.text = "12345678"
        return textField
    }
    
    func createNicknameField(from settings: TextFieldViewFieldSettings) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = settings.placeholder
        textField.textContentType = .nickname
        textField.returnKeyType = settings.returnKeyType
        return textField
    }
    
     func createSpacer() -> UIView {
        let progress = UIView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = .appGray
        return progress
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        spacer.backgroundColor = .appPurple
        
        fieldLabel.textColor = .appPurple
        fieldLabel.text = textField.placeholder
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        spacer.backgroundColor = .appGray
        
        fieldLabel.textColor = .appGray
        if let text = textField.text, text.isEmpty {
            fieldLabel.text = " "
        }
        
        delegate?.textFieldEndEditing(self)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard textField.textContentType == .password else { return }
        
        if let text = textField.text, text.count > 0 {
            eyeButton.backgroundImageState = textField.isSecureTextEntry ? .active : .insecure
        } else {
            eyeButton.backgroundImageState = .inactive
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldReturn(self)
        return true
    }
}
