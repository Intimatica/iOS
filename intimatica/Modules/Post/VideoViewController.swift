//
//  VideoViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/2/21.
//

import UIKit

class VideoViewController: BasePostViewController {
    // MARK: - Properties
    private lazy var playerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        return view
    }()
    
    
    // MARK: - Initializers
    init(presenter: VideoPresenterProtocol) {
        super.init(navigationBarType: .addFavorite)
        
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
        display()
    }
    
    // MARK: - Layout
    func setupView() {
        scrollView.addSubview(headerStack)
        scrollView.addSubview(markdownView)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(tagsStack)
        headerStack.addArrangedSubview(SpacerView(height: 20, backgroundColor: .clear))
        headerStack.addArrangedSubview(playerView)
        
        playerView.addSubview(headerImageView)
    }
    
    func setupConstraints() {
        let contentLayoutGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            headerImageView.topAnchor.constraint(equalTo: playerView.topAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: playerView.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor),
            
            headerStack.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: Constants.headerStackLeadingTrailing),
            headerStack.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: Constants.headerStackTop),
//            headerStack.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: -Constants.headerStackLeadingTrailing),
            headerStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -2 * Constants.headerStackLeadingTrailing),
            
            markdownView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            markdownView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: Constants.markdownViewTop),
            markdownView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            markdownView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
            markdownView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

}

// MARK: - VideoViewProtocol
extension VideoViewController: VideoViewProtocol {
    func display() {
        titleLabel.text = "Половое созревание у мальчиков"
        
        ["asdfjlkj", "asldfj dlksfjlsk"].forEach { tagName in
            tagsStack.addArrangedSubview(createTagView(with: tagName))
        }
        
        tagsStack.addArrangedSubview(UIView())
        
        headerImageView.kf.indicatorType = .activity
        headerImageView.kf.setImage(with: URL(string: "https://intimatica.key42.net/uploads/small_alt_60340_6387968bd4.jpg?133790842"))
    }
}

// MARK: -Helper/Constants
extension VideoViewController.Constants {
    
}
