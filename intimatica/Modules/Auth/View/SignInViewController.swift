//
//  SignInViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import UIKit

class SignInViewController: AuthViewController {
    // MARK: - Properties
    private lazy var emailView = TextFieldView(field: .email(
                                                .settings(placeholder: l10n("AUTH_EMAIL_FIELD_PLACEHOLDER"), returnKeyType: .next)))
    
    private lazy var passwordView = TextFieldView(field: .password(
                                                    .settings(placeholder: l10n("AUTH_PASSWORD_FIELD_PLACEHOLDER"), returnKeyType: .done)))
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(l10n("SIGN_IN_FORGOT_PASSWORD_BUTTON"), for: .normal)
        button.setTitleColor(.appPurple, for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .small, fontWeight: .medium)
        button.addAction { [weak self] in
            self?.presenter.forgotPasswordButtonDidTap()
        }
        return button
    }()
    
    private var presenter: SignInPresenterProtocol!
    
    // MARK: - Initializers
    init(presenter: SignInPresenterProtocol) {
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
        
        setupView()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupView() {
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        
        view.addSubview(forgotPasswordButton)
        
        titleLabel.text = l10n("SIGN_IN_VIEW_TITLE")
        authButton.setTitle(l10n("SIGN_IN_BUTTON_TITLE"), for: .normal)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.authButtonTop),
            
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: Constants.forgotPasswordButtonWidth),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: Constants.forgotPasswrodButtonHeight),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordButton.topAnchor.constraint(equalTo: authButton.bottomAnchor, constant: Constants.forgotPasswordButtonTop)
        ])
    }
}

// MARK: - Helper/Constraints
extension SignInViewController {
    private struct Constants {
        static let authButtonTop: CGFloat = 80
        static let forgotPasswordButtonTop: CGFloat = 25
        static let forgotPasswrodButtonHeight: CGFloat = 50
        static let forgotPasswordButtonWidth: CGFloat = 200
        
    }
}

// MARK: - TextFieldViewDelegate
extension SignInViewController: TextFieldViewDelegate {
    func textFieldEndEditing(_ textFieldView: TextFieldView) {
        if textFieldView == emailView {
            
        }
    }
    
    func textFieldShouldReturn(_ textFieldView: TextFieldView) {
        if textFieldView == emailView {
            passwordView.textField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
}
