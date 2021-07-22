//
//  SignUpViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

final class SignUpViewController: AuthViewController {
    
    // MARK: - Properties
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
    }
    
    // MARK: - Layout
    private func setupView() {
        passwordView.textField.returnKeyType = .next
        
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(passwordConfirmedView)

        titleLabel.text = L10n("SIGN_UP_VIEW_TITLE")
        authButton.setTitle(L10n("SIGN_UP_BUTTON_TITLE"), for: .normal)
    }
    
    private func setupConstraints() {
    }
}

// MARK: - Helper/Constraints
extension SignUpViewController {
    private struct Constants {
    }
}
