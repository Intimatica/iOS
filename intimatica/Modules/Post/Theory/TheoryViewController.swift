//
//  StoryViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import UIKit

class TheoryViewController: BasePostViewController {
    // MARK: - Properties
    private let presenter: TheoryPresenterProtocol
    
    // MARK: - Initializers
    init(presenter: TheoryPresenterProtocol) {
        self.presenter = presenter
        
        super.init(presenter: presenter,  rightBarButtonType: .favorite)
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
        
        scrollView.delegate = self
        
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(headerStack)
        scrollView.addSubview(spacerView)
        scrollView.addSubview(markdownView)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(tagsStackView)
        headerStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .clear))
        headerStack.addArrangedSubview(authorView)
        headerStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .clear))
    }
    
    private func setupConstraints() {
        let contentLayoutGuide = scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            headerImageView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 200),

            headerStack.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: Constants.headerStackLeadingTrailing),
            headerStack.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: Constants.headerStackTop),
            headerStack.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: -Constants.headerStackLeadingTrailing),
            
            spacerView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            spacerView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: Constants.spacerViewTop),
            spacerView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            
            markdownView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            markdownView.topAnchor.constraint(equalTo: spacerView.bottomAnchor, constant: Constants.markdownViewTop),
            markdownView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            markdownView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
            markdownView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func setupAction() {
        markdownView.onRendered = { [weak self] height in
            self?.hideSpinner()
            self?.markdownView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// MARK: - TheoryViewProtocol
extension TheoryViewController: TheoryViewProtocol {
    func display(_ theoryPost: TheoryPostQuery.Data.Post) {
        guard
            let imageUrl = theoryPost.image?.url,
            let tags = theoryPost.tags?.compactMap({ $0?.name }),
            let authorName = theoryPost.author?.name,
            let authorJobTitle = theoryPost.author?.jobTitle,
            let authorPhotoUrl = theoryPost.author?.photo?.url,
            let content = theoryPost.postTypeDz.first??.asComponentPostTypeTheory?.content
        else {
            return
        }
        
        headerImageView.kf.indicatorType = .activity
        headerImageView.kf.setImage(with: URL(string: AppConstants.serverURL + imageUrl))
        
        titleLabel.text = theoryPost.title
        tagsStackView.fill(by: tags)
        authorView.fill(by: .author(authorName), jobTitle: authorJobTitle, avatar: authorPhotoUrl)
        
        markdownView.load(markdown: fixContentStrapiLinks(content), enableImage: true)
    }
    
    func display(_ error: Error) {
        hideSpinner()
        showError(error.localizedDescription)
    }
}

// MARK: - UIScrollViewDelegate
extension TheoryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            title = titleLabel.text
        } else {
            title = ""
        }
    }
}
