//
//  AuthViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: - Properties
    private var presenter: WelcomePresenterProtocol!
    
    private lazy var titleImage: UIImageView = {
        let imageName = "Intimatica_title"
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("WELCOME_SIGN_IN"), for: .normal)
        button.titleLabel?.font = .rubik(fontWeight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .appYellow
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("WELCOME_SIGN_UP"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .rubik(fontWeight: .medium)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n("WELCOME_GREETING_TEXT")
        label.textColor = .white
        label.font = .rubik(fontWeight: .medium)
        return label
    }()
    
    // MARK: - Initializers
    init(presenter: WelcomePresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActions()
    }
 
    // MARK: - Layout
    private func setupUI() {
        view.backgroundColor = .appPurple
        
        view.addSubview(titleImage)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(welcomeLabel)

        NSLayoutConstraint.activate([
            titleImage.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: Constants.signInButtonTop),
            titleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleImageLeadingTrailing),
            titleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.titleImageLeadingTrailing),
            titleImage.heightAnchor.constraint(equalTo: titleImage.widthAnchor,
                                               multiplier: titleImage.frame.height / titleImage.frame.width),

            signInButton.widthAnchor.constraint(equalToConstant: Constants.signInButtonWidth),
            signInButton.heightAnchor.constraint(equalToConstant: Constants.signInButtonHeigh),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.singInButtonTop),

            signUpButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor),
            signUpButton.heightAnchor.constraint(equalTo: signInButton.heightAnchor),
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: Constants.signUpButtonTop),
            signUpButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),

            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: Constants.welcomeLabelTop)
        ])
    }
    
    private func setupActions() {
        signInButton.addAction { [weak self] in
            self?.presenter.singInButtonDidTap()
        }
        
        signUpButton.addAction { [weak self] in
            self?.presenter.singUpButtonDidTap()
        }
    }
}

// MARK: - Helpers/Constraints
private extension WelcomeViewController {
    struct Constants {
        static let signInButtonTop: CGFloat = -30
        static let titleImageLeadingTrailing: CGFloat = 78
        static let signInButtonWidth: CGFloat = 285
        static let signInButtonHeigh: CGFloat = 50
        static let singInButtonTop: CGFloat = -50
        static let signUpButtonTop: CGFloat = 20
        static let welcomeLabelTop: CGFloat = 30
    }
}
