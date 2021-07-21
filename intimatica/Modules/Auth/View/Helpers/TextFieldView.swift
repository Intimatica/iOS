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
    func textFieldEndEditing(_ textFieldView: TextFieldView)
    func textFieldShouldReturn(_ textFieldView: TextFieldView)
}

final class TextFieldView: UIView {
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var fieldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Email"
        label.textColor = .gray
        label.font = .rubik(fontSize: .small, fontWeight: .regular)
        label.isHidden = true
        return label
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Some error message"
        label.textColor = .appRed
        label.font = .rubik(fontSize: .small, fontWeight: .regular)
        label.isHidden = true
        return label
    }()
    
    lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "eye_gray_cross_out"), for: .normal)
//        button.setBackgroundImage(UIImage(named: "eye_black_cross_out"), for: .highlighted)
//        button.setBackgroundImage(UIImage(named: "eye_black"), for: .selected)
        button.addAction {
            
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
            addShowPasswordButton()
        }
    }
    
    private func addShowPasswordButton() {
        view.addSubview(showPasswordButton)
        
        NSLayoutConstraint.activate([
            showPasswordButton.topAnchor.constraint(equalTo: textField.topAnchor),
            showPasswordButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            showPasswordButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            showPasswordButton.widthAnchor.constraint(equalTo: showPasswordButton.heightAnchor)
        ])
    }
}

// MARK: - Helpers/Contraints
extension TextFieldView {
    private struct Constants {
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
        progress.backgroundColor = .gray
        return progress
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        spacer.backgroundColor = .appPurple
        
        delegate?.textFieldEndEditing(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        spacer.backgroundColor = .gray
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldReturn(self)
        return true
    }
}
