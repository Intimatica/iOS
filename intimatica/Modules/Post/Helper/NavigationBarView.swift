//
//  NavigationBarView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/30/21.
//

import UIKit

class NavigationBarView: UIView {

    // MARK: - Properties
    lazy var closeButton = CloseButton()
    var actionButton: UIButton!
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    enum ActionButtonType {
        case addFavorite
        case addCourse
    }
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "add_to_favorite_button_icon"), for: .normal)
        return button
    }()
    
    private lazy var courseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("ADD_TO_MY_COURSES_BUTTON_LABEL"), for: .normal)
        button.setImage(UIImage(named: "add_to_course_button_icon"), for: .normal)
        button.setTitle(L10n("ADDED_TO_MY_COURSES_BUTTON_LABEL"), for: .application)
        button.setImage(UIImage(named: "added_to_course_button_icon"), for: .application)
        button.titleLabel?.font = .rubik(fontSize: .small, fontWeight: .regular)
        button.setTitleColor(.appPurple, for: .normal)
        button.setTitleColor(.appPurple, for: .application)
        return button
    }()
    
    // MARK: - Initializers
    init(actionButtonType: ActionButtonType) {
        super.init(frame: .zero)
        
        setupUI(actionButtonType: actionButtonType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupUI(actionButtonType: ActionButtonType) {
        switch(actionButtonType) {
        case .addFavorite:
            actionButton = favoriteButton
        case .addCourse:
            actionButton = courseButton
        }
    
        translatesAutoresizingMaskIntoConstraints = false
        
//        addSubview(actionButton)
//        addSubview(titleLabel)
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
//            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//
//            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.actionButtonLeading),
//            actionButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.closeButtonTopBottom),
//            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.closeButtonTopBottom),
//
//            titleLabel.leadingAnchor.constraint(equalTo: actionButton.trailingAnchor, constant: Constants.titleLabelLeading),
//
            view.heightAnchor.constraint(equalToConstant: 35),
            closeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
//            closeButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Constants.closeButtonLeadingTrailing),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.closeButtonTopBottom),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.closeButtonLeadingTrailing),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.closeButtonTopBottom),
            
        ])
    }
}

// MARK: - Helper/Constants
extension NavigationBarView {
    private struct Constants {
        static let actionButtonLeading: CGFloat = 12
        static let actionButtonWidth: CGFloat = 130
        
        static let titleLabelLeading: CGFloat = 15
        
        static let closeButtonTopBottom: CGFloat = 0
        static let closeButtonLeadingTrailing: CGFloat = 15
    }
}
