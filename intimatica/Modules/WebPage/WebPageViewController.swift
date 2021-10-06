//
//  WebPageViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/14/21.
//

import UIKit
import MarkdownView
import SafariServices

class WebPageViewController: PopViewController {
    // MARK: - Properties
    private let presenter: WebPagePresenterProtocol
    
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
        
        view.addSubview(markdownView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            markdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            markdownView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Constants.markdownViewTop),
            markdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            markdownView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupAction() {
        markdownView.onRendered = { [weak self] _ in
            self?.hideActivityIndicator()
        }
        
        markdownView.onTouchLink = { request in
            guard let url = request.url else { return false }

            if url.scheme == "file" {
                return false
            } else if url.scheme == "https" {
                UIApplication.shared.open(url)
//                let safari = SFSafariViewController(url: url)
//                self?.present(safari, animated: true, completion: nil)
//                self?.navigationController?.pushViewController(safari, animated: true)
                return false
            } else {
                return false
            }
        }
    }
}

// MARK: - Helper/Constants
extension WebPageViewController {
    struct Constants {
        static let markdownViewTop: CGFloat = 15
    }
}

// MARK: - WebPageViewProtocol
extension WebPageViewController: WebPageViewProtocol {
    func display(_ text: String) {
        markdownView.load(markdown: fixContentStrapiLinks(text), enableImage: true)
    }
    
    func displayError(_ message: String) {
        hideActivityIndicator()
        showError(message)
    }
    
    func fixContentStrapiLinks(_ text: String) -> String {
        let regex = "(\\!\\[.*\\]\\()(\\/.+)(\\))"
        let replaceBy = "$1" + AppConstants.serverURL + "$2$3"
        return text.replacingOccurrences(of: regex, with: replaceBy, options: .regularExpression)
    }
}
