//
//  CourseFinishedViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/9/21.
//

import UIKit
import Kingfisher

class CourseFinishedViewController: PopViewController {
    // MARK: - Properties
    private let subTitle: String
    private let imageUrl: String
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .title, fontWeight: .bold)
        label.text = L10n("COURSE_FINISHED_TITLE")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .regular, fontWeight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: FixedWidthAspectFitImageView = {
        let imageView = FixedWidthAspectFitImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "course_finished_image")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var button: UIRoundedButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .appDarkPurple
        button.setTitle(L10n("COURSE_FINISHED_BUTTON_TITLE"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .bold)
        return button
    }()
    
    
    // MARK: - Initializers
    init(title: String, imageUrl: String) {
        self.subTitle = title
        self.imageUrl = imageUrl
        
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
        setupActions()
    }
    
    // MARK: - Layout
    func setupView() {
        subTitleLabel.text = subTitle
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: AppConstants.serverURL + imageUrl), options: AppConstants.kingFisherOptions)
        
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(imageView)
        view.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.titleLabelTop),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLabelLeadingTrailing),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.titleLabelLeadingTrailing),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.subTitleLabelTop),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: Constants.imageViewTop),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageViewLeadingTrailing),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.imageViewLeadingTrailing),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.buttonTop),
            button.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func setupActions() {
        button.addAction { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}


// MARK: - Helper/Constants
extension CourseFinishedViewController {
    struct Constants {
        static let titleLabelTop: CGFloat = 72
        static let titleLabelLeadingTrailing: CGFloat = 45
        
        static let subTitleLabelTop: CGFloat = 20
        
        static let imageViewTop: CGFloat = 20
        static let imageViewLeadingTrailing: CGFloat = 35
        
        static let buttonTop: CGFloat = 42
        static let buttonHeight:  CGFloat = 50
    }
}

