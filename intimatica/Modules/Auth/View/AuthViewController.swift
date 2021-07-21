//
//  AuthViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/15/21.
//

import UIKit

class AuthViewController: UIViewController {

    // MARK: - Properties
    private var presenter: AuthPresenterProtocol!
    
    lazy var emailView = TextFieldView(field: .email(
                                                .settings(placeholder: L10n("AUTH_EMAIL_FIELD_PLACEHOLDER"), returnKeyType: .next)))
    
    lazy var passwordView = TextFieldView(field: .password(
                                                    .settings(placeholder: L10n("AUTH_PASSWORD_FIELD_PLACEHOLDER"), returnKeyType: .done)))
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "close_button_image"), for: .normal)
        
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
        button.backgroundColor = .appPurple
        button.titleLabel?.font = .rubik(fontWeight: .medium)
        
        return button
    }()
    
    // MARK: - Initializer
    init(presenter: AuthPresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActions()
    }
    
    // MARK: - Layout
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(authButton)
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: Constants.closeButtonWidth),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.closeButtonTopTrailing),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.closeButtonTopTrailing),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLabelLeadingTrailing),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.titleLabelTop),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.titleLabelLeadingTrailing),
            
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.stackViewTop),
            stackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            authButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            authButton.heightAnchor.constraint(equalToConstant: Constants.authButtonHeigh),
            authButton.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func setupActions() {
        closeButton.addAction { [weak self] in
            self?.presenter.closeButtonDidTap()
        }
        
        authButton.addAction { [weak self] in
            guard let self = self,
                  let email = self.emailView.textField.text,
                  let password = self.passwordView.textField.text
            else { return }
            
            self.presenter.doAuthButtonDidTap(email: email, password: password)
        }
    }
}

// MARK: - Helper/Constants
extension AuthViewController {
    private struct Constants {
        static let closeButtonWidth: CGFloat = 40
        static let closeButtonTopTrailing: CGFloat = 15
        
        static let titleLabelLeadingTrailing: CGFloat = 45
        static let titleLabelTop: CGFloat = 120
        static let titleLabel: CGFloat = 45
        
        static let stackViewSpacing: CGFloat = 30
        static let stackViewTop: CGFloat = 20
        
        static let authButtonHeigh: CGFloat = 50
    }
}

// MARK: - Helper/UIField
extension AuthViewController {
    func createTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n(text)
        label.font = .rubik(fontSize: .title, fontWeight: .medium)
        return label
    }
}
