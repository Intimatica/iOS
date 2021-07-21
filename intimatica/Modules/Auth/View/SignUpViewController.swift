//
//  SignUpViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

class SignUpViewController: AuthViewController {
    
    // MARK: - Properties
    private lazy var emailView = TextFieldView(field: .email(
                                                .settings(placeholder: l10n("AUTH_EMAIL_FIELD_PLACEHOLDER"),returnKeyType: .next)
    ))
    
    private lazy var passwordView = TextFieldView(field: .password(
                                                    .settings(placeholder: l10n("AUTH_PASSWORD_FIELD_PLACEHOLDER"),returnKeyType: .next)
    ))

    private lazy var passwordConfirmedView = TextFieldView(field: .password(
                                                            .settings(placeholder: l10n("AUTH_PASSWORD_CONFIRM_FIELD_PLACEHOLDER"), returnKeyType: .done)
    ))
    
    private lazy var termsView = TermsAndConditionsView()
    
    private var presenter: SignUpPresenterProtocol!
    
    // MARK: - Initializers
    init(presenter: SignUpPresenterProtocol) {
        super.init(presenter: presenter)
        
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        emailView.delegate = self
        passwordView.delegate = self
        passwordConfirmedView.delegate = self
        
        setupView()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Layout
    private func setupView() {
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(passwordConfirmedView)
        
        view.addSubview(termsView)
        
        titleLabel.text = l10n("SIGN_UP_VIEW_TITLE")
        authButton.setTitle(l10n("SIGN_UP_BUTTON_TITLE"), for: .normal)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            termsView.heightAnchor.constraint(equalToConstant: Constants.termsViewHeight),
            termsView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.termsViewTop),
            termsView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            termsView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            authButton.topAnchor.constraint(equalTo: termsView.bottomAnchor, constant: Constants.authButtonTop)
        ])
    }
    
    private func setupActions() {
        authButton.addAction { [weak self] in
            guard let self = self,
                  let email = self.emailView.textField.text,
                  let password = self.passwordView.textField.text,
                  let passwordConfirm = self.passwordConfirmedView.textField.text
            else { return }
            
            self.presenter.doAuthButtonDidTap(email: email, password: password, passwordConfirm: passwordConfirm)
        }
    }
}

// MARK: - Helper/Constraints
extension SignUpViewController {
    private struct Constants {
        static let termsViewHeight: CGFloat = 45
        static let termsViewTop: CGFloat = 30
        static let authButtonTop: CGFloat = 20
    }
}

// MARK: - AuthViewProtocol
extension SignUpViewController: AuthViewProtocol {
    func showValidationError(for fieldContent: FieldType, message: String) {
        switch fieldContent {
        case .email:
            emailView.showError(message: l10n(message))
        case .password:
            passwordView.showError(message: l10n(message))
        case .passwordConfirm:
            passwordConfirmedView.showError(message: l10n(message))
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
extension SignUpViewController: TextFieldViewDelegate {
    func textFieldEndEditing(_ textFieldView: TextFieldView) {
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
    
    func textFieldShouldReturn(_ textFieldView: TextFieldView) {
        if textFieldView == emailView {
            passwordView.textField.becomeFirstResponder()
        } else if textFieldView == passwordView {
            passwordConfirmedView.textField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
}
