//
//  SignUpViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

final class SignUpViewController: AuthViewController {
    
    // MARK: - Properties
    private lazy var termsView = TermsAndConditionsViewHelper()
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
        
        view.addSubview(termsView)
        
        titleLabel.text = L10n("SIGN_UP_VIEW_TITLE")
        authButton.setTitle(L10n("SIGN_UP_BUTTON_TITLE"), for: .normal)
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
}

// MARK: - Helper/Constraints
extension SignUpViewController {
    private struct Constants {
        static let termsViewHeight: CGFloat = 45
        static let termsViewTop: CGFloat = 30
        static let authButtonTop: CGFloat = 20
    }
}
