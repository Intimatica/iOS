//
//  AuthViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/15/21.
//

import UIKit

class AuthViewController: UIViewController {

    // MARK: - Properties
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "close_button_image"), for: .normal)
        return button
    }()
    
    lazy var titleLabel = createTitleLabel(with: "Регистрация")
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 80
        return stackView
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIRoundedButton()
        button.backgroundColor = .appPurple
//        button.setTitle("Зарегистроваться", for: .normal)
        button.setTitle(l10n("AUTH_SIGN_UP"), for: .normal)
        
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Layout
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
        ])
    }
    
}

// MARK: - Helper
extension AuthViewController {
    func createTitleLabel(with text: String) -> UIView {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = l10n(text)
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }
}
