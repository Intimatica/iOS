//
//  NavigationBar.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/12/21.
//

import UIKit

final class NavigationBar: UIView {
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "burger_menu_button"), for: .normal)
        return button
    }()
    
    lazy var tagFilterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "tags_filter_button"), for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(tagFilterButton)
    }
    
    private func setupConstraints() {
        stackView.fillSuperview()
        
        NSLayoutConstraint.activate([
            tagFilterButton.widthAnchor.constraint(equalTo: tagFilterButton.heightAnchor),
            
            heightAnchor.constraint(equalToConstant: Constants.viewHeight)
        ])
    }
}

// MARK: - Helper/Constants
extension NavigationBar {
    struct Constants {
        static let stackViewSpacing: CGFloat = 15
        static let viewHeight: CGFloat = 30
    }
}
