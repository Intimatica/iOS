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
    case gender(TextFieldViewFieldSettings)
    case birthdate(TextFieldViewFieldSettings)
    case code(TextFieldViewFieldSettings)
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
            
        case .gender(let settings):
            textField = createGenderField(from: settings)
        
        case .birthdate(let settings):
            textField = createBirthDateField(from: settings)
            
        case .code(let settings):
            textField = createCodeField(from: settings)
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

    // MARK: - Public
    func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        spacer.backgroundColor = .appRed
    }
    
    func hideError() {
        errorLabel.isHidden = true
    }
    
    func setText(_ text: String?) {
        if let text = text, !text.isEmpty {
            fieldLabel.textColor = .appGray
            fieldLabel.text = textField.placeholder
            textField.text = text
        }
    }
    
    
    // MARK: - Private
    private func addEyeButton() {
        view.addSubview(eyeButton)
        
        NSLayoutConstraint.activate([
            eyeButton.topAnchor.constraint(equalTo: textField.topAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            eyeButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            eyeButton.widthAnchor.constraint(equalTo: eyeButton.heightAnchor, multiplier: 17.72 / 14.6)
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
//        textField.text = "a@key42.net"
        return textField
    }
    
    func createPasswordField(from settings: TextFieldViewFieldSettings) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = settings.placeholder
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.returnKeyType = settings.returnKeyType
//        textField.text = "12345678"
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
    
    func createGenderField(from settings: TextFieldViewFieldSettings) -> UITextField {
        let pickerKeyboard = PickerKeyboard()
        pickerKeyboard.data = ["Male", "Female", "Other", "I don't know"]
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputView = pickerKeyboard
        textField.inputAccessoryView = pickerKeyboard.inputAccessoryView
        textField.placeholder = settings.placeholder
        textField.returnKeyType = settings.returnKeyType
                
        pickerKeyboard.textField = textField
        return textField
    }
    
    func createBirthDateField(from settings: TextFieldViewFieldSettings) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = settings.placeholder
        textField.returnKeyType = settings.returnKeyType
        textField.setInputViewDatePicker(target: self,
                                        selector: #selector(birthDateFieldTapDone),
                                        minimumDate: Calendar.current.date(byAdding: .year, value: -128, to: Date()),
                                        maximumDate: Calendar.current.date(byAdding: .year, value: -16, to: Date()))
        return textField
    }
    
    func createCodeField(from settings: TextFieldViewFieldSettings) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = settings.placeholder
        textField.returnKeyType = settings.returnKeyType
        return textField
    }
    
     func createSpacer() -> UIView {
        let progress = UIView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = .appGray
        return progress
    }
    
    @objc func birthDateFieldTapDone() {
        if let datePicker = self.textField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .short
            self.textField.text = dateformatter.string(from: datePicker.date)
        }
        endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        spacer.backgroundColor = .appDarkPurple
        
        fieldLabel.textColor = .appDarkPurple
        fieldLabel.text = textField.placeholder
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        fieldLabel.textColor = .appGray
        
        if let text = textField.text, text.isEmpty {
            fieldLabel.text = " "
            spacer.backgroundColor = .appGray
        } else {
            spacer.backgroundColor = .appPurple
        }
        
        delegate?.textFieldEndEditing(self)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        spacer.backgroundColor = .appDarkPurple
        hideError()

        NSObject.cancelPreviousPerformRequests(
            withTarget: self,
            selector: #selector(TextFieldView.stopedEditing),
            object: textField)
        self.perform(
            #selector(TextFieldView.stopedEditing),
            with: textField,
            afterDelay: 0.75)
        
        // eye button for password field
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
    
    @objc func stopedEditing(textField: UITextField) {
        delegate?.textFieldEndEditing(self)
    }
}
