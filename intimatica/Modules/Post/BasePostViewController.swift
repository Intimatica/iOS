//
//  BasePostViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/30/21.
//

import UIKit
import MarkdownView
import Kingfisher

class BasePostViewController: UIViewController {
    // MARK: - Properties
    private let presenter: BasePostPresenterProtocol
    var navigationBarView: NavigationBarView!
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    lazy var headerImageView: FixedWidthAspectFitImageView = {
        let imageView = FixedWidthAspectFitImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var headerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.headerStackSpacing
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .title, fontWeight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tagsStackView = TagStackView()
    lazy var authorView = AuthorView()
    lazy var spacerView = SpacerView(height: 1, backgroundColor: .init(hex: 0x9E6FFF))
    
    lazy var markdownView: MarkdownView = {
        let md = MarkdownView()
        md.translatesAutoresizingMaskIntoConstraints = false
        md.isScrollEnabled = false
        
        return md
    }()
    
    //MARK: - Initializers
    init(presenter: BasePostPresenterProtocol, navigationBarType: NavigationBarView.ActionButtonType) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        navigationBarView = NavigationBarView(actionButtonType: navigationBarType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupActions()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        showSpinner()
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(navigationBarView)
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupActions() {
        navigationBarView.backButton.addAction { [weak self] in
            // TODO: fix this
            self?.navigationController?.popViewController(animated: true)
        }
        
        navigationBarView.actionButton.addAction { [weak self] in
            guard let self = self else { return }
            
            if self.navigationBarView.state == .inactive {
                self.presenter.addToFarovites()
                self.navigationBarView.state = .active
            } else {
                self.presenter.removeFromFavorites()
                self.navigationBarView.state = .inactive
            }
        }
    }

    func fixContentStrapiLinks(_ text: String) -> String {
        let regex = "(\\!\\[.*\\]\\()(\\/.+)(\\))"
        let replaceBy = "$1" + AppConstants.serverURL + "$2$3"
        return text.replacingOccurrences(of: regex, with: replaceBy, options: .regularExpression)
    }
}

// MARK: - Helper/Constants
extension BasePostViewController {
    struct Constants {
        static let headerStackSpacing: CGFloat = 10
        static let headerStackLeadingTrailing: CGFloat = 24
        static let headerStackTop: CGFloat = 30
        
        static let spacerViewTop: CGFloat = 10
        static let markdownViewTop: CGFloat = 10
    }
}

// MARK: - BaseViewProtocol
extension BasePostViewController: BasePostViewProtocol {
    func setIsFavotire(_ isFavorite: Bool) {
        navigationBarView.state = isFavorite ? .active : .inactive
    }
}

extension MarkdownView {
    var htmlURL: URL? {
        let bundle = Bundle(for: MarkdownView.self)
        return bundle.url(forResource: "index",
                          withExtension: "html") ??
               bundle.url(forResource: "index",
                          withExtension: "html",
                          subdirectory: "MarkdownView.bundle")
    }
}
