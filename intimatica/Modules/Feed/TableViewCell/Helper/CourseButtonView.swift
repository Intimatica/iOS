//
//  CourseButtonView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/17/21.
//

import UIKit

final class CourseButtonView: UIView {
    enum State {
        case active, inactive
    }
    
    enum Design {
        case postFeed, postView
    }
    
    // MARK: - Properties
    var state: State = .inactive {
        didSet {
            switch state {
            case .active:
                textLabel.text = L10n("COURSE_SELECTION_BUTTON_TITLE_ACTIVE")
                imageView.image = UIImage(named: Constants.imageNameForActive)
            case .inactive:
                textLabel.text = L10n("COURSE_SELECTION_BUTTON_TITLE_INACTIVE")
                imageView.image = UIImage(named: Constants.imageNameForInactive)
            }
        }
    }
    
    private let design: Design
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .small, fontWeight: .medium)
        label.textColor = .appPurple
        label.text = L10n("COURSE_SELECTION_BUTTON_TITLE_INACTIVE")
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.imageNameForInactive)
        return imageView
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers
    init(design: Design) {
        self.design = design
        
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if layer.cornerRadius != bounds.height / 2 {
            layer.cornerRadius = bounds.height / 2
        }
    }
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        if design == .postView {
            layer.borderWidth = 1
            layer.borderColor = UIColor.appPurple.cgColor
        }
        
        addSubview(textLabel)
        addSubview(imageView)
        addSubview(actionButton)
                
//        actionButton.fillSuperview()
    }
    
    private func setupConstraints() {
        
        let textLabelTopBottom = design == .postFeed ? Constants.textLabelTopBottomForPostFeed : Constants.textLabelTopBottomForPostView
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.textLabelLeading),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: textLabelTopBottom),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -textLabelTopBottom),
  
            // QUESTION
//            imageView.heightAnchor.constraint(equalTo: textLabel.heightAnchor, multiplier: 0.1),
//            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeightWidth),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewHeightWidth),
            
            imageView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: Constants.imageViewLeading),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.imageViewTrailing),
            
            // QUESTION: button heigth is over big
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            actionButton.topAnchor.constraint(equalTo: topAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            actionButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Public
    func toggleState() {
        state = state == .inactive ? .active : .inactive
    }
}

// MARK: - Helper/Constants
extension CourseButtonView {
    struct Constants {
        static let imageNameForActive = "course_selection_button_image_active"
        static let imageNameForInactive = "course_selection_button_image_inactive"
        
        static let textLabelLeading: CGFloat = 15
        static let textLabelTopBottomForPostFeed: CGFloat = 7
        static let textLabelTopBottomForPostView: CGFloat = 3
        
        static let imageViewHeightWidth: CGFloat = 14
        static let imageViewLeading: CGFloat = 5
        static let imageViewTrailing: CGFloat = 15
    }
}
