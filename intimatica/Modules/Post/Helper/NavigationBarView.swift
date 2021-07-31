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
        label.font = .rubik(fontSize: .regular, fontWeight: .bold)
        label.textAlignment = .center
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
    
    private lazy var bottomBorderLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        let borderWidth: CGFloat = 1
        layer.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth)
        return layer
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
        
        addSubview(actionButton)
        addSubview(titleLabel)
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: Constants.viewHeight),

            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.actionButtonLeading),
            actionButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.closeButtonTopBottom),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.closeButtonTopBottom),
            
            actionButton.widthAnchor.constraint(equalTo: actionButton.heightAnchor),

            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: actionButton.trailingAnchor, constant: Constants.titleLabelLeadingTrailing),
            titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -Constants.titleLabelLeadingTrailing),

            closeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.closeButtonTopBottom),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.closeButtonLeadingTrailing),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.closeButtonTopBottom),
            
        ])
    }
    
    func showBottomBorder() {
        self.layer.addSublayer(bottomBorderLayer)
    }
    
    func hideBottomBorder() {
        bottomBorderLayer.removeFromSuperlayer()
    }
}

// MARK: - Helper/Constants
extension NavigationBarView {
    private struct Constants {
        static let viewHeight: CGFloat = 35
        
        static let actionButtonLeading: CGFloat = 15
//        static let actionButtonWidth: CGFloat = 130
        
        static let titleLabelLeadingTrailing: CGFloat = 15
        
        static let closeButtonTopBottom: CGFloat = 0
        static let closeButtonLeadingTrailing: CGFloat = 15
    }
}
