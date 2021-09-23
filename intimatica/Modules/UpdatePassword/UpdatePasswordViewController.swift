//
//  ChangePasswordViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/22/21.
//

import UIKit

class UpdatePasswordViewController: UIViewController {
    // MARK: - Properties
    private let presenter: UpdatePasswordPresenterDelegate
    
    private lazy var currentPassword = TextFieldView(field: .password(.settings(
                                                                        placeholder: L10n("CHANGE_PASSWORD_CURRENT_PASSWORD_TITLE"),
                                                                        returnKeyType: .next)))
    
    private lazy var newPassword = TextFieldView(field: .password(.settings(
                                                                    placeholder: L10n("CHANGE_PASSWORD_NEW_PASSWORD_TITLE"),
                                                                    returnKeyType: .next)))
    
    private lazy var confirmPassword = TextFieldView(field: .password(.settings(
                                                                        placeholder: L10n("CHANGE_PASSWORD_CONFIRM_PASSWORD_TITLE"),
                                                                        returnKeyType: .done)))
    
    private lazy var updatePasswordButton: UIRoundedButton = {
        let button = UIRoundedButton(title: L10n("CHANGE_PASSWORD_CONFIRM_BUTTON_TITLE_UPDATE"),
                              titleColor: .white,
                              font: .rubik(fontSize: .regular, fontWeight: .bold),
                              backgroundColor: .appDarkPurple)
        button.setBackgroundColor(.appGray, for: .disabled)
        button.isEnabled = false
        return button
    }()
    
    private lazy var backBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "    "
        barButton.tintColor = .appDarkPurple
        return barButton
    }()
    
    //MARK: - Initializers
    init(presenter: UpdatePasswordPresenterDelegate) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n("CHANGE_PASSWORD_PAGE_TITLE")
        
        currentPassword.delegate = self
        newPassword.delegate = self
        confirmPassword.delegate = self
        
        setupView()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(currentPassword)
        view.addSubview(newPassword)
        view.addSubview(confirmPassword)
        view.addSubview(updatePasswordButton)
    }
    
    private func setupConstraints() {
        currentPassword.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(Constants.leadingTrailing)
            make.top.equalTo(view).offset(Constants.currentPasswordTop)
        }
        
        newPassword.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(Constants.leadingTrailing)
            make.top.equalTo(currentPassword.snp.bottom).offset(Constants.newPasswordTop)
        }
        
        confirmPassword.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(Constants.leadingTrailing)
            make.top.equalTo(newPassword.snp.bottom).offset(Constants.confirmPasswordTop)
        }
        
        updatePasswordButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.updatePasswordButtonHeight)
            make.leading.trailing.equalTo(view).inset(Constants.leadingTrailing)
            make.top.equalTo(confirmPassword.snp.bottom).offset(Constants.updatePasswordButtonTop)
        }
    }
}

// MARK: - Helper/Constants
extension UpdatePasswordViewController {
    struct Constants {
        static let leadingTrailing: CGFloat = 25

        static let currentPasswordTop: CGFloat = 60
        static let newPasswordTop: CGFloat = 30
        static let confirmPasswordTop: CGFloat = 30
        static let updatePasswordButtonHeight: CGFloat = 50
        static let updatePasswordButtonTop: CGFloat = 40
    }
}

// MARK: - UpdatePasswordViewControllerDelegate
extension UpdatePasswordViewController: UpdatePasswordViewControllerDelegate {
    func enableUpdateButton() {
        updatePasswordButton.isEnabled = true
    }
    
    func disableUpdateButton() {
        updatePasswordButton.isEnabled = false
    }
    
    func getCurrentPassword() -> String? {
        currentPassword.textField.text
    }
    
    func getNewPassword() -> String? {
        newPassword.textField.text
    }
    
    func getConfirmPassword() -> String? {
        confirmPassword.textField.text
    }
    
    func showValidationError(for fieldContent: UpdatePasswordFieldType, message: String) {
        hideSpinner()
        
        switch fieldContent {
        case .currentPassword:
            currentPassword.showError(message: L10n(message))
        case .newPassword:
            newPassword.showError(message: L10n(message))
        case .confirmPassword:
            confirmPassword.showError(message: L10n(message))
        }
    }
    
    func hideValidationError(for fieldContent: UpdatePasswordFieldType) {
        switch fieldContent {
        case .currentPassword:
            currentPassword.hideError()
        case .newPassword:
            newPassword.hideError()
        case .confirmPassword:
            confirmPassword.hideError()
        }
    }
}

// MARK: - TextFieldViewDelegate
extension UpdatePasswordViewController: TextFieldViewDelegate {
    func textFieldEndEditing(_ textFieldView: TextFieldView) {
        switch textFieldView {
        case currentPassword:
            presenter.validate(field: .currentPassword, with: textFieldView.textField.text)
        case newPassword:
            presenter.validate(field: .newPassword, with: textFieldView.textField.text)
        case confirmPassword:
            presenter.validate(field: .confirmPassword, with: textFieldView.textField.text)
            
        default:
            print("\(textFieldView) not found")
        }
    }
    
    func textFieldShouldReturn(_ textFieldView: TextFieldView) {
        if textFieldView == currentPassword {
            newPassword.textField.becomeFirstResponder()
        } else if textFieldView == newPassword {
            confirmPassword.textField.becomeFirstResponder()
        } else {
            confirmPassword.textField.endEditing(true)
        }
    }
}
