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
        button.setTitle(l10n("WELCOME_SIGN_IN"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .appYellow
        
        button.addAction { [weak self] in
            self?.presenter.singInButtonDidTap()
        }
        
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(l10n("WELCOME_SIGN_UP"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
        button.addAction { [weak self] in
            self?.presenter.singUpButtonDidTap()
        }
        
        return button
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = l10n("WELCOME_GREETING_TEXT")
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
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
    }
    
//    override func loadView() {
//        super.loadView()
//        setupUI()
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Layout
    private func setupUI() {
        view.backgroundColor = .appPurple
        
        view.addSubview(titleImage)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(welcomeLabel)

        NSLayoutConstraint.activate([
            titleImage.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -30),
            titleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 78),
            titleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -78),
            titleImage.heightAnchor.constraint(equalTo: titleImage.widthAnchor,
                                               multiplier: titleImage.frame.height / titleImage.frame.width),

            signInButton.widthAnchor.constraint(equalToConstant: 285),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            signUpButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor),
            signUpButton.heightAnchor.constraint(equalTo: signInButton.heightAnchor),
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),

            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30)
        ])
    }
}
