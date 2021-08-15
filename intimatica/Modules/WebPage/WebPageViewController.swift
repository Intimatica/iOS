//
//  WebPageViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/14/21.
//

import UIKit
import MarkdownView

class WebPageViewController: UIViewController {
    // MARK: - Properties
    private var presenter: WebPagePresenterProtocol!
    private lazy var closeButton = CloseButton()
    private lazy var markdownView: MarkdownView = {
        let markdownView = MarkdownView()
        markdownView.translatesAutoresizingMaskIntoConstraints = false
        return markdownView
    }()
    
    // MARK: - Initializers
    init(presenter: WebPagePresenterProtocol) {
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
        
        showSpinner()
        
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
            self?.hideSpinner()
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
        hideSpinner()
        showError(message)
    }
}
