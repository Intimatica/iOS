//
//  PopViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/18/21.
//

import UIKit

class PopViewController: UIViewController {
    // MARK: - Properties
    lazy var closeButton = CloseButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupActions()
    }

    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: Constants.closeButtonWidth),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.closeButtonTopTrailing),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.closeButtonTopTrailing),
        ])
    }
    
    private func setupActions() {
        closeButton.addAction { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - Helper/Constants
extension PopViewController {
    struct Constants {
        static let closeButtonWidth: CGFloat = 40
        static let closeButtonTopTrailing: CGFloat = 15
    }
}
