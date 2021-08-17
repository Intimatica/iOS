//
//  NavigationBarView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/30/21.
//

import UIKit

class NavigationBarView: UIView {
    enum ActionButtonType {
        case addFavorite
        case addCourse
    }
    
    enum State {
        case active, inactive
    }
    
    // MARK: - Properties
    var state: State = .inactive {
        didSet {
            switch actionButtonType {
            case .addFavorite:
                setFavoriteButtonState(state)
            case .addCourse:
                setCourseButtonState(state)
            }
        }
    }
    
    private let actionButtonType: ActionButtonType
    var actionButton: UIButton!
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "back_button_icon"), for: .normal)
        return button
    }()
        
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .regular, fontWeight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favorite_inactive"), for: .normal)
        return button
    }()
    
    private lazy var courseButton = CourseButtonView(design: .postView)
    
    private lazy var bottomBorderLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        let borderWidth: CGFloat = 1
        layer.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth)
        return layer
    }()
    
    // MARK: - Initializers
    init(actionButtonType: ActionButtonType) {
        self.actionButtonType = actionButtonType
        
        super.init(frame: .zero)

        setupUI(actionButtonType: actionButtonType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupUI(actionButtonType: ActionButtonType) {
        var rightButtonView: UIView!
        
        switch(actionButtonType) {
        case .addFavorite:
            actionButton = favoriteButton
            rightButtonView = favoriteButton
            addFavoriteButton()
        case .addCourse:
            addCourseButton()
            actionButton = courseButton.actionButton
            rightButtonView = courseButton
        }
    
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(rightButtonView)

        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: Constants.viewHeight),

            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.backButtonTopBottom),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.backButtonLeadingTrailing),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.backButtonTopBottom),

            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: Constants.titleLabelLeadingTrailing),
            titleLabel.trailingAnchor.constraint(equalTo: rightButtonView.leadingAnchor, constant: -Constants.titleLabelLeadingTrailing),
        ])
    }
    
    private func addFavoriteButton() {
        addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor, multiplier: Constants.actionButtonRatio),
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.actionButtonTopBottom),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.actionButtonTopBottom),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.actionButtonTrailing),
        ])
    }
    
    private func addCourseButton() {
        addSubview(courseButton)
        
        NSLayoutConstraint.activate([
            courseButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.actionButtonTopBottom),
            courseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.actionButtonTrailing),
        ])
        
    }
    
    // TODO: refactor this
    func showBottomBorder() {
        self.layer.addSublayer(bottomBorderLayer)
    }
    
    func hideBottomBorder() {
        bottomBorderLayer.removeFromSuperlayer()
    }
    
    private func setFavoriteButtonState(_ state: State) {
        switch state {
        case .active:
            actionButton.setBackgroundImage(UIImage(named: "favorite_active"), for: .normal)
        case .inactive:
            actionButton.setBackgroundImage(UIImage(named: "favorite_inactive"), for: .normal)
        }
    }
    
    private func setCourseButtonState(_ state: State) {
        switch state {
        case .active:
            courseButton.state = .active
        case .inactive:
            courseButton.state = .inactive
        }
    }
}

// MARK: - Helper/Constants
extension NavigationBarView {
    private struct Constants {
        static let viewHeight: CGFloat = 35

        static let backButtonTopBottom: CGFloat = 0
        static let backButtonLeadingTrailing: CGFloat = 15
        
        static let actionButtonTrailing: CGFloat = 15
        static let actionButtonTopBottom: CGFloat = 5
        static let actionButtonRatio: CGFloat = 15.7 / 19.75
        
        static let titleLabelLeadingTrailing: CGFloat = 15
    }
}
