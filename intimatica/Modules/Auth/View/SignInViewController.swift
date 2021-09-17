//
//  SignInViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import UIKit

final class SignInViewController: AuthViewController {
    // MARK: - Properties
    private let presenter: SignInPresenterProtocol
    
    // MARK: - Initializers
    init(presenter: SignInPresenterProtocol) {
        self.presenter = presenter
        
        super.init(presenter: presenter)
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
        
        contentView.addSubview(forgotPasswordButton)
        
        titleLabel.text = L10n("SIGN_IN_VIEW_TITLE")
        authButton.setTitle(L10n("SIGN_IN_BUTTON_TITLE"), for: .normal)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([            
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: Constants.forgotPasswordButtonWidth),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: Constants.forgotPasswrodButtonHeight),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            forgotPasswordButton.topAnchor.constraint(equalTo: authButton.bottomAnchor, constant: Constants.forgotPasswordButtonTop),
            forgotPasswordButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
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
        static let forgotPasswordButtonTop: CGFloat = 20
        static let forgotPasswrodButtonHeight: CGFloat = 20
        static let forgotPasswordButtonWidth: CGFloat = 200
    }
}
