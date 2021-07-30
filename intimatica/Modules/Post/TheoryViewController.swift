//
//  StoryViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import UIKit
import MarkdownView

class TheoryViewController: BasePostViewController {
    // MARK: - Properties
    private var presenter: TheoryPresenterProtocol!
    
    private lazy var headImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .title, fontWeight: .bold)
        
        return label
    }()
    
    private lazy var tagsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var markdownView: MarkdownView = {
        let md = MarkdownView()
        md.translatesAutoresizingMaskIntoConstraints = false
        md.isScrollEnabled = true
        return md
    }()
    
    // MARK: - Initializers
    init(presenter: TheoryPresenterProtocol) {
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
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        
        view.addSubview(markdownView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            markdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            markdownView.topAnchor.constraint(equalTo: view.topAnchor),
            markdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            markdownView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - TheoryViewProtocol
extension TheoryViewController: TheoryViewProtocol {
    func display(_ theoryPost: TheoryPostQuery.Data.Post) {
        guard let content = theoryPost.postType.first??.asComponentPostTypeTheory?.content else {
            return
        }
        
        markdownView.load(markdown: content, enableImage: true)
//        markdownView.onRendered = { [weak self] height in
//            self?.md.ViewHeight.constant = height
//            self?.view.setNeedsLayout()
//        }
    }
}
