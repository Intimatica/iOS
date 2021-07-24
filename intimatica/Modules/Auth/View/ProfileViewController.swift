//
//  ProfileViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/22/21.
//

import UIKit

class ProfileViewController: AuthViewController {
    // MARK: - Properties
    private var presenter: ProfilePresenter!
    
    
    // MARK: - Initializers
    init(presenter: ProfilePresenter) {
        super.init(presenter: presenter)
        
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
        setupActions()
    }
    
    // MARK: - Layout
    private func setupView() {
        titleLabel.text = L10n("PROFILE_VIEW_TITLE")
        
        stackView.addArrangedSubview(nicknameView)
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupActions() {
        
    }
}
