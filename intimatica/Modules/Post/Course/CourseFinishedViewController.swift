//
//  CourseFinishedViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/9/21.
//

import UIKit

class CourseFinishedViewController: UIViewController {
    // MARK: - Properties
    lazy var closeButton = CloseButton()
    
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
        label.text = L10n("COURSE_FINISHED_SUBTITLE")
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
        button.backgroundColor = .appPurple
        button.setTitle(L10n("COURSE_FINISHED_BUTTON_TITLE"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .bold)
        return button
    }()
    
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupView()
        setupConstraints()
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
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(imageView)
        view.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: Constants.closeButtonWidth),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.closeButtonTopTrailing),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.closeButtonTopTrailing),
            
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
        closeButton.addAction { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        button.addAction { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}


// MARK: - Helper/Constants
extension CourseFinishedViewController {
    struct Constants {
        static let closeButtonWidth: CGFloat = 40
        static let closeButtonTopTrailing: CGFloat = 15
        
        static let titleLabelTop: CGFloat = 72
        static let titleLabelLeadingTrailing: CGFloat = 45
        
        static let subTitleLabelTop: CGFloat = 20
        
        static let imageViewTop: CGFloat = 20
        static let imageViewLeadingTrailing: CGFloat = 35
        
        static let buttonTop: CGFloat = 42
        static let buttonHeight:  CGFloat = 50
    }
}

