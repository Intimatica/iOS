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
    
    private lazy var helpButton = createMenuButton(title: L10n("MENU_ITEM_HELP"), imageName: "menu_help")
    private lazy var aboutButton = createMenuButton(title: L10n("MENU_ITEM_ABOUT"), imageName: "menu_about")
    private lazy var termsAndConditionsButton = createMenuButton(title: L10n("MENU_ITEM_TERMS_AND_CONDITIONS"),
                                                                 imageName: "menu_terms_and_conditions")
    private lazy var privacyPolicyButtton = createMenuButton(title: L10n("MENU_ITEM_PRIVACY_POLICY"), imageName: "menu_privacy")
    
    private lazy var applyForPremiumButton = ApplyForPremiumButton()
    
    private lazy var logoutButton = createMenuButton(title: L10n("MENU_ITEM_LOGOUT"), imageName: "menu_logout")
    
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
        view.addSubview(privacyPolicyButtton)
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
        
        privacyPolicyButtton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.trailing.equalTo(view).inset(Constants.buttonLeadingTrailing)
            make.top.equalTo(termsAndConditionsButton.snp.bottom).offset(Constants.buttonTop)
        }
        
        applyForPremiumButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.trailing.equalTo(view).inset(Constants.buttonLeadingTrailing)
            make.top.equalTo(privacyPolicyButtton.snp.bottom).offset(Constants.applyForPremiumButtonTop)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.trailing.equalTo(view).inset(Constants.buttonLeadingTrailing)
            make.bottom.equalTo(view).offset(-Constants.logoutButtonBottom)
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
        
        privacyPolicyButtton.addAction { [weak self] in
            self?.presenter.buttonDidTap(.privacyPolicy)
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
        static let buttonFont: UIFont = .rubik(fontSize: .subRegular, fontWeight: .medium)
        static let buttonImageEdgeInsets = UIEdgeInsets(top: 10, left: -10, bottom: 10, right: 0)
        static let butttonImageContentInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        static let helpButtonTop: CGFloat = 150
        static let buttonTop: CGFloat = 5
        static let buttonLeadingTrailing: CGFloat = 30
        static let buttonHeight: CGFloat = 50
        
        static let applyForPremiumButtonTop: CGFloat = 40

        static let logoutButtonBottom: CGFloat = 100
    }
}
