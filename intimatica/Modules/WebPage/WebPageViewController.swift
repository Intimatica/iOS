//
//  WebPageViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/14/21.
//

import UIKit
import MarkdownView

class WebPageViewController: UIViewController, ActivityIndicatable {
    // MARK: - Properties
    private let presenter: WebPagePresenterProtocol
    lazy var activityContainerView: UIView = {
        UIView(frame: .zero)
    }()
    private lazy var closeButton = CloseButton()
    private lazy var markdownView: MarkdownView = {
        let markdownView = MarkdownView()
        markdownView.translatesAutoresizingMaskIntoConstraints = false
        return markdownView
    }()
    
    // MARK: - Initializers
    init(presenter: WebPagePresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
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
        
        showActivityIndicator()
        
        presenter.viewDidLoad()
    }
    
    // MAKR: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(markdownView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: Constants.closeButtonWidth),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.closeButtonTopTrailing),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.closeButtonTopTrailing),
            
            markdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            markdownView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Constants.markdownViewTop),
            markdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            markdownView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupAction() {
        closeButton.addAction { [weak self] in
            self?.dismiss(animated: true)
        }
        
        markdownView.onRendered = { [weak self] _ in
            self?.hideActivityIndicator()
        }
    }
}

// MARK: - Helper/Constants
extension WebPageViewController {
    struct Constants {
        static let closeButtonWidth: CGFloat = 40
        static let closeButtonTopTrailing: CGFloat = 15
        
        static let markdownViewTop: CGFloat = 15
    }
}

// MARK: - WebPageViewProtocol
extension WebPageViewController: WebPageViewProtocol {
    func display(_ text: String) {
        markdownView.load(markdown: text, enableImage: true)
    }
    
    func displayError(_ message: String) {
        hideActivityIndicator()
        showError(message)
    }
}
