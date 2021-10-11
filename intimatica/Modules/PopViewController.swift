//
//  PopViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/18/21.
//

import UIKit

class PopViewController: UIViewController, ActivityIndicatable {
    // MARK: - Properties
    lazy var activityContainerView: UIView = {
        UIView(frame: .zero)
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "close_button"), for: .normal)
        return button
    }()
    
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
        static let closeButtonWidth: CGFloat = 21
        static let closeButtonTopTrailing: CGFloat = 15
    }
}
