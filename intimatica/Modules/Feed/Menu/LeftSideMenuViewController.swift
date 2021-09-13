//
//  BurgerMenuViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/26/21.
//

import UIKit
import SnapKit

class LeftSideMenuViewController: UIViewController {
    // MARK: - Properties
    private let presenter: LeftSideMenuPresenterDelegate
    
    private lazy var helpButton = createMenuButton(title: L10n("MENU_ITEM_HELP"), imageName: "help_button_icon_x2")
    private lazy var aboutButton = createMenuButton(title: L10n("MENU_ITEM_ABOUT"), imageName: "about_icon_x2")
    private lazy var termsAndConditionsButton = createMenuButton(title: L10n("MENU_ITEM_TERMS_AND_CONDITIONS")
                                                             , imageName: "terms_and_condition_icon_x2")
    
    private lazy var applyForPremiumButton = ApplyForPremiumButton()
    
    private lazy var logoutButton = createMenuButton(title: L10n("MENU_ITEM_LOGOUT"), imageName: "logout_icon_x2")
    
    // MARK: - Initializers
    init(presenter: LeftSideMenuPresenterDelegate) {
        self.presenter = presenter

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(helpButton)
        view.addSubview(aboutButton)
        view.addSubview(termsAndConditionsButton)
        view.addSubview(applyForPremiumButton)
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        helpButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.trailing.equalTo(view).inset(Constants.buttonLeadingTrailing)
            make.top.equalTo(view).offset(Constants.helpButtonTop)
        }
        
        aboutButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.trailing.equalTo(view).inset(Constants.buttonLeadingTrailing)
            make.top.equalTo(helpButton.snp.bottom).offset(Constants.buttonTop)
        }
        
        termsAndConditionsButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.trailing.equalTo(view).inset(Constants.buttonLeadingTrailing)
            make.top.equalTo(aboutButton.snp.bottom).offset(Constants.buttonTop)
        }
        
        applyForPremiumButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight * 1.2)
            make.leading.trailing.equalTo(view).inset(Constants.buttonLeadingTrailing)
            make.top.equalTo(termsAndConditionsButton.snp.bottom).offset(40)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.trailing.equalTo(view).inset(Constants.buttonLeadingTrailing)
            make.bottom.equalTo(view).offset(-100)
        }
    }
    
    private func setupActions() {
        helpButton.addAction { [weak self] in
            self?.presenter.buttonDidTap(.help)
        }
        
        aboutButton.addAction { [weak self] in
            self?.presenter.buttonDidTap(.about)
        }
        
        termsAndConditionsButton.addAction { [weak self] in
            self?.presenter.buttonDidTap(.termsAndConditions)
        }
        
        applyForPremiumButton.addAction { [weak self] in
            self?.presenter.buttonDidTap(.applyForPremium)
        }
        
        logoutButton.addAction { [weak self] in
            self?.presenter.buttonDidTap(.logout)
        }
        
    }
    
    private func createMenuButton(title: String, imageName: String) -> UIButton {
        let button = UIButton(title: title,
                              titleColor: .black,
                              font: Constants.buttonFont,
                              backgroundColor: .clear)
        
        button.setImage(UIImage(named: imageName), for: .normal)

        button.imageEdgeInsets = Constants.buttonImageEdgeInsets
        button.contentHorizontalAlignment = .leading
        button.contentEdgeInsets = Constants.butttonImageContentInsets
        return button
    }
    
}

// MARK: - Helper/Constants
extension LeftSideMenuViewController {
    struct Constants {
        static let buttonFont: UIFont = .rubik(fontSize: .regular, fontWeight: .medium)
        static let buttonImageEdgeInsets = UIEdgeInsets(top: 10, left: -20, bottom: 10, right: 0)
        static let butttonImageContentInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        
        static let helpButtonTop: CGFloat = 150
        static let buttonTop: CGFloat = 5
        static let buttonLeadingTrailing: CGFloat = 40
        static let buttonHeight: CGFloat = 50

        static let logoutButtonBottom: CGFloat = 100
    }
}
