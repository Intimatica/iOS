//
//  AuthViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/15/21.
//

import UIKit

class AuthViewController: PopViewController {
    // MARK: - Properties
    private let presenter: AuthPresenterDelegate
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    lazy var emailView = TextFieldView(field: .email(
                                                .settings(placeholder: L10n("AUTH_EMAIL_FIELD_PLACEHOLDER"), returnKeyType: .next)))
    
    lazy var passwordView = TextFieldView(field: .password(
                                                    .settings(placeholder: L10n("AUTH_PASSWORD_FIELD_PLACEHOLDER"), returnKeyType: .done)))
    
    lazy var passwordConfirmedView = TextFieldView(field: .password(
                                                            .settings(placeholder: L10n("AUTH_PASSWORD_CONFIRM_FIELD_PLACEHOLDER"),  returnKeyType: .done)
    ))
    
    lazy var nicknameView = TextFieldView(field: .nickname(
                                                            .settings(placeholder: L10n("PROFILE_NICKNAME_FIELD_TITLE"),  returnKeyType: .next)
    ))
    
    lazy var genderView = TextFieldView(field: .gender(
                                                            .settings(placeholder: L10n("PROFILE_SEX_FIELD_TITLE"),  returnKeyType: .next)
    ))
    
    lazy var birthdateView = TextFieldView(field: .birthdate(
                                                            .settings(placeholder: L10n("PROFILE_BIRTHDATE_FIELD_TITLE"),  returnKeyType: .next)
    ))
   
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("SIGN_IN_FORGOT_PASSWORD_BUTTON"), for: .normal)
        button.setTitleColor(.appDarkPurple, for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .regular)
        
        return button
    }()
    
    lazy var accountExistButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("SIGN_UP_I_HAVE_ACCOUNT_BUTTON"), for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .regular)
        button.setTitleColor(.appDarkPurple, for: .normal)
        return button
    }()
    
    lazy var titleLabel = createTitleLabel(with: "")
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    lazy var authButton: UIButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .rubik(fontWeight: .medium)
        button.setBackgroundColor(.appDarkPurple, for: .normal)
        button.setBackgroundColor(.appGray, for: .disabled)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Initializer
    init(presenter: AuthPresenterDelegate) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActions()
        enableHideKeyboardOnTap()
    }
    
    // MARK: - Layout
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(authButton)
                
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.titleLabelLeadingTrailing),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.titleLabelLeadingTrailing),
            
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.stackViewTop),
            stackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            authButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.authButtonTop),
            authButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            authButton.heightAnchor.constraint(equalToConstant: Constants.authButtonHeigh),
            authButton.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func setupActions() {
        closeButton.addAction { [weak self] in
            self?.dismiss(animated: true)
        }
        
        authButton.addAction { [weak self] in
            guard let self = self,
                  let email = self.emailView.textField.text,
                  let password = self.passwordView.textField.text
            else { return }
            
            self.showActivityIndicator(with: self.view.bounds, opacity: 0.5)
            self.presenter.doAuthButtonDidTap(email: email, password: password)
        }
    }
}

// MARK: - Helper/Constants
extension AuthViewController {
    private struct Constants {
        static let titleLabelLeadingTrailing: CGFloat = 45
        
        static let stackViewSpacing: CGFloat = 30
        static let stackViewTop: CGFloat = 20
        
        static let authButtonTop: CGFloat = 40
        static let authButtonHeigh: CGFloat = 50
    }
}

// MARK: - Helper/UIField
extension AuthViewController {
    func createTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n(text)
        label.font = .rubik(fontSize: .title, fontWeight: .bold)
        return label
    }
}

// MARK: - AuthViewProtocol
extension AuthViewController: AuthViewDelegate {
    func displayError(_ message: String) {
        hideActivityIndicator()
        showError(message)
    }
    
    func changeAuthButton(isEnabled: Bool) {
        authButton.isEnabled = isEnabled
    }
    
    func showNotification(_ message: String) {
        hideActivityIndicator()
        
        showError(message)
    }
    
    func showValidationError(for fieldContent: FieldType, message: String) {
        hideActivityIndicator()
        
        switch fieldContent {
        case .email:
            emailView.showError(message: L10n(message))
        case .password:
            passwordView.showError(message: L10n(message))
        case .passwordConfirm:
            passwordConfirmedView.showError(message: L10n(message))
        }
    }
    
    func hideValidationError(for fieldContent: FieldType) {
        switch fieldContent {
        case .email:
            emailView.hideError()
        case .password:
            passwordView.hideError()
        case .passwordConfirm:
            passwordConfirmedView.hideError()
        }
    }
}

// MARK: - TextFieldViewDelegate
extension AuthViewController: TextFieldViewDelegate {
    @objc func textFieldEndEditing(_ textFieldView: TextFieldView) {
        switch textFieldView {
        case emailView:
            presenter.validate(.email, with: emailView.textField.text)
        case passwordView:
            presenter.validate(.password, with: passwordView.textField.text)
        case passwordConfirmedView:
            presenter.validate(.passwordConfirm, with: passwordConfirmedView.textField.text)
        default:
            break
        }
    }
    
    @objc func textFieldShouldReturn(_ textFieldView: TextFieldView) {
        if textFieldView == emailView {
            passwordView.textField.becomeFirstResponder()
        } else if textFieldView == passwordView && passwordView.textField.returnKeyType == .next {
            passwordConfirmedView.textField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
}
