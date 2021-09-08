//
//  FavoriteView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/15/21.
//

import UIKit

final class FavoriteButtonView: UIView {
    enum State {
        case active, inactive
    }
    
    // MARK: - Properties
    var state: State = .inactive {
        didSet {
            switch state {
            case .inactive:
                backgroundColor = Constants.viewBackgroundColorForInactive
                imageView.image = UIImage(named: Constants.imageNameForInactive)
            case .active:
                backgroundColor = Constants.viewBackgroundColorForActive
                imageView.image = UIImage(named: Constants.imageNameForActive)
            }
        }
    }
    
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
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Constants.viewBackgroundColorForInactive
        layer.cornerRadius = Constants.viewWidthHeight / 2
        layer.masksToBounds = true

        addSubview(imageView)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constants.viewWidthHeight),
            heightAnchor.constraint(equalToConstant: Constants.viewWidthHeight),
            
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewWidth),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        actionButton.fillSuperview()
    }
    
    // MARK: - Public
    func toggleState() {
        state = state == .inactive ? .active : .inactive
    }
}

// MARK: - Helper/Constants
extension FavoriteButtonView {
    struct Constants {
        static let imageNameForActive = "favorite_button_active"
        static let imageNameForInactive = "favorite_button_inactive"
        
        static let viewWidthHeight: CGFloat = 30
        static let viewBackgroundColorForInactive: UIColor = .appDarkPurple.withAlphaComponent(0.5)
        static let viewBackgroundColorForActive: UIColor = .appDarkPurple
        
        static let imageViewWidth: CGFloat = 13
        static let imageViewHeight: CGFloat = 17
    }
}
