//
//  SignUpViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

class SignUpViewController: AuthViewController {
    
    // MARK: - Properties
    private lazy var emailView = TextFieldView(field: .email,
                                               placeholder: l10n("AUTH_EMAIL_FIELD_PLACEHOLDER"))
    private lazy var passwordView = TextFieldView(field: .password,
                                                  placeholder: l10n("AUTH_PASSWORD_FIELD_PLACEHOLDER"))
    private lazy var passwordConfirmedView = TextFieldView(field: .password,
                                                           placeholder: l10n("AUTH_PASSWORD_CONFIRM_FIELD_PLACEHOLDER"))
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupView() {
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(passwordConfirmedView)
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 1),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}
