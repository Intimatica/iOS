//
//  StoryViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import UIKit

class TheoryViewController: BasePostViewController {
    // MARK: - Properties
    private var presenter: TheoryPresenterProtocol!
    
    // MARK: - Initializers
    init(presenter: TheoryPresenterProtocol) {
        super.init(navigationBarType: .addCourse)
        
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
        
        showSpinner()
        
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(headerStack)
        scrollView.addSubview(spacerView)
        scrollView.addSubview(markdownView)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(tagsStack)
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
            headerImageView.widthAnchor.constraint(equalTo: view.widthAnchor),

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
            let content = theoryPost.postType.first??.asComponentPostTypeTheory?.content
        else {
            return
        }
        
        headerImageView.kf.indicatorType = .activity
        headerImageView.kf.setImage(with: URL(string: AppConstants.serverURL + imageUrl))
        
        titleLabel.text = theoryPost.title
        
        tags.forEach { tagName in
            tagsStack.addArrangedSubview(createTagView(with: tagName))
        }
        tagsStack.addArrangedSubview(UIView())
        
        authorView.imageView.kf.indicatorType = .activity
        authorView.imageView.kf.setImage(with: URL(string: AppConstants.serverURL + authorPhotoUrl))
        authorView.label.setAttributedText(withString: L10n("AUTHOR") + "\n" + authorName + "\n" + authorJobTitle,
                                           boldString: authorName,
                                           font: authorView.label.font)

        markdownView.load(markdown: content, enableImage: true)
        
        markdownView.onRendered = { [weak self] _ in
            self?.hideSpinner()
        }
    }
}
