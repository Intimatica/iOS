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
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "WelcomeScreenBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.center = view.center
        return imageView
    }()

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n("WELCOME_GREETING_TEXT")
        label.textColor = .white
        label.font = .rubik(fontSize: .subTitle, fontWeight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("WELCOME_SIGN_UP"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .rubik(fontWeight: .medium)
        button.backgroundColor = .appYellow
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("WELCOME_SIGN_IN"), for: .normal)
        button.titleLabel?.font = .rubik(fontWeight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
 
    // MARK: - Layout
    private func setupUI() {
        view.addSubview(backgroundImage)
        
        view.addSubview(welcomeLabel)
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        

        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(equalToConstant: Constants.welcomeLabelWidth),
            welcomeLabel.heightAnchor.constraint(equalToConstant: Constants.welcomeLabelHeight),
            welcomeLabel.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -Constants.welcomeLabelBottom),
         
            signUpButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            signUpButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.singUpButtonTop),

            signInButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            signInButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: Constants.signInButtonTop),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
        static let buttonWidth: CGFloat = 285
        static let buttonHeight: CGFloat = 50
        
        static let welcomeLabelWidth: CGFloat = 280
        static let welcomeLabelHeight: CGFloat = 60
        static let welcomeLabelBottom: CGFloat = 30
        
        static let singUpButtonTop: CGFloat = -50
        static let signInButtonTop: CGFloat = 20
    }
}
