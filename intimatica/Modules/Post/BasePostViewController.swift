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
    
    private var isFavorite = false
    private var rightBarButtonType: RightBarButtonItem.ButtonType = .favorite
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    lazy var headerImageView: FixedWidthAspectFitImageView = {
//        let imageView = FixedWidthAspectFitImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()

    lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    
    private lazy var backBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "    "
        barButton.tintColor = .appDarkPurple
        return barButton
    }()
        
    private lazy var rightBarButtonItem = RightBarButtonItem(buttonType: rightBarButtonType)
    
    //MARK: - Initializers
    init(presenter: BasePostPresenterProtocol, rightBarButtonType: RightBarButtonItem.ButtonType) {
        self.presenter = presenter
        self.rightBarButtonType = rightBarButtonType
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.backBarButtonItem = backBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        setupView()
        setupConstraints()
        setupActions()
        
        showSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupActions() {
        rightBarButtonItem.primaryAction = UIAction(image: rightBarButtonItem.image) { [weak self] _ in
            guard let self = self else { return }

            self.isFavorite = !self.isFavorite

            if self.isFavorite {
                self.presenter.addToFarovites()
                self.rightBarButtonItem.state = .active
            } else {
                self.presenter.removeFromFavorites()
                self.rightBarButtonItem.state = .inactive
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
        static let favoriteActiveImageName = "favorite_active"
        static let favoriteInactiveImageName = "favorite_inactive"
        
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
        self.isFavorite = isFavorite
        if isFavorite {
            rightBarButtonItem.state = .active
        }
    }
}
