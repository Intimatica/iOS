//
//  SignUpViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit
import FirebaseAnalytics

final class SignUpViewController: AuthViewController {
    
    // MARK: - Properties
    private let presenter: SignUpPresenterProtocol
    
    // MARK: - Initializers
    init(presenter: SignUpPresenterProtocol) {
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
        passwordConfirmedView.delegate = self
        
        setupView()
        setupConstraints()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        EventLogger.logEvent("sign_up_screen_open")
        FirebaseAnalytics.Analytics.logEvent(AnalyticsParameterScreenName, parameters: [
            "screen_name": "SignUp",
        ])
    }
    
    // MARK: - Layout
    private func setupView() {
        passwordView.textField.returnKeyType = .next
        
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(passwordConfirmedView)

        titleLabel.text = L10n("SIGN_UP_VIEW_TITLE")
        authButton.setTitle(L10n("SIGN_UP_BUTTON_TITLE"), for: .normal)
        
        contentView.addSubview(accountExistButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            accountExistButton.widthAnchor.constraint(equalToConstant: Constants.accountExistButtonWidth),
            accountExistButton.heightAnchor.constraint(equalToConstant: Constants.accountExistButtonHeight),
            accountExistButton.topAnchor.constraint(equalTo: authButton.bottomAnchor, constant: Constants.accountExistButtonTop),
            accountExistButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            accountExistButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func setupActions() {
        accountExistButton.addAction { [weak self] in
            self?.presenter.accountExistButtonDidTap()
        }
        
        closeButton.addAction { [weak self] in
            EventLogger.logEvent("sign_up_screen_closed")
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - Helper/Constraints
extension SignUpViewController {
    private struct Constants {
        static let accountExistButtonTop: CGFloat = 20
        static let accountExistButtonWidth: CGFloat = 250
        static let accountExistButtonHeight: CGFloat = 20
    }
}
