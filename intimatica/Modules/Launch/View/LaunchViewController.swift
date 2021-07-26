//
//  LaunchViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

class LaunchViewController: UIViewController {
    // MARK: - Properties
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "LaunchSreenBackground")
        return imageView
    }()
    
    private lazy var titleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Intimatica_title")
        return imageView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Layout
    func setupView() {
        view.addSubview(backgroundImage)
        view.addSubview(titleImage)
    }
    
    func setupConstraints() {        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleImage.heightAnchor.constraint(equalToConstant: Constants.titleImageHeight),
            titleImage.widthAnchor.constraint(equalTo: titleImage.heightAnchor, multiplier: Constants.titleImageRatio),
            titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

// MARK: - Helper/Constants
extension LaunchViewController {
    struct Constants {
        static let titleImageHeight: CGFloat = 45
        static let titleImageRatio: CGFloat = 277.5 / 42.75
    }
}
