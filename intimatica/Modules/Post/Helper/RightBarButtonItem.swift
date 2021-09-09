//
//  RightBarButtonItem.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/20/21.
//

import UIKit

class RightBarButtonItem: UIBarButtonItem {
    enum ButtonType {
        case favorite
        case course
    }
    
    enum State {
        case active, inactive
    }
    
    // MARK: - Properties
    private let buttonType: ButtonType
    private lazy var courseButtonView = CourseButtonView(design: .postView)
    
    var state: State = .inactive {
        didSet {
            switch buttonType {
            case .course:
                setCourseButtonState(state)
            case .favorite:
                setFavoriteButtonState(state)
            }
        }
    }
    
    override var primaryAction: UIAction? {
        didSet {
            guard
                buttonType == .course,
                let action = primaryAction
            else { return }
            
            courseButtonView.actionButton.addAction(action, for: .touchUpInside)
        }
    }
    
    // MARK: - Initializers
    init(buttonType: ButtonType) {
        self.buttonType = buttonType
     
        super.init()

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    private func setupUI() {
        tintColor = .appDarkPurple
        
        switch buttonType {
        case .course:
            customView = courseButtonView

        case .favorite:
            image = UIImage(named: Constants.favoriteInactiveImageName)
        }
    }
    
    // MARK: - Private
    private func setFavoriteButtonState(_ state: State) {
        switch state {
        case .active:
            image = UIImage(named: Constants.favoriteActiveImageName)
        case .inactive:
            image = UIImage(named: Constants.favoriteInactiveImageName)
        }
    }
    
    private func setCourseButtonState(_ state: State) {
        switch state {
        case .active:
            courseButtonView.state = .active
        case .inactive:
            courseButtonView.state = .inactive
        }
    }
}

// MARK: - Helper/Constants
extension RightBarButtonItem {
    struct Constants {
        static let favoriteActiveImageName = "favorite_active"
        static let favoriteInactiveImageName = "favorite_inactive"
    }
}
