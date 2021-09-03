//
//  LaunchViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

class LaunchViewController: UIViewController {
    // MARK: - Properties
    private var presenter: LaunchPresenterProtocol!
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "LaunchSreenBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Intimatica_title")
        return imageView
    }()
    
    // MARK: - Initializers
    init(presenter: LaunchPresenterProtocol) {
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
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
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
