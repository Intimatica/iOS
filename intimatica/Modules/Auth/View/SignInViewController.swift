//
//  SignInViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import UIKit

final class SignInViewController: AuthViewController {
    // MARK: - Properties
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
        
        titleLabel.text = L10n("SIGN_IN_VIEW_TITLE")
        authButton.setTitle(L10n("SIGN_IN_BUTTON_TITLE"), for: .normal)
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
    
    private func setupActions() {
        forgotPasswordButton.addAction { [weak self] in
            self?.presenter.forgotPasswordButtonDidTap()
        }
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
