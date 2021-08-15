//
//  ProfileViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Properties
    private var presenter: ProfilePresenterProtocol!
    
    private lazy var logoutButton: UIRoundedButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("PROFILE_PAGE_LOGOUT_BUTTON_TITLE"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(.appPurple, for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .bold)
    
        return button
    }()
    
    // MARK: - Initializers
    init(presenter: ProfilePresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.widthAnchor.constraint(equalToConstant: 250),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupAction() {
        logoutButton.addAction { [weak self] in
            self?.presenter.logoutButtonDidTap()
        }
    }
}
