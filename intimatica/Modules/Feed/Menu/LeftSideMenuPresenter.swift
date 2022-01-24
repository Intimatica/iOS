//
//  BurgerMenuPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/26/21.
//

import Foundation

enum LeftSideMenuActionButton {
    case help, about, termsAndConditions, privacyPolicy, applyForPremium, logout
}

protocol LeftSideMenuPresenterDelegate: AnyObject {
    func buttonDidTap(_ button: LeftSideMenuActionButton)
}

final class LeftSideMenuPresenter {
    // MARK: - Properties
    let router: FeedRouter
    let authUseCase: AuthUseCaseProtocol
    
    // MARK: - Initializers
    init(router: FeedRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.authUseCase = dependencies.authUseCase
    }
}

extension LeftSideMenuPresenter: LeftSideMenuPresenterDelegate {
    func buttonDidTap(_ button: LeftSideMenuActionButton) {
        switch button {
            case .help:
                router.trigger(.helpPage)
                EventLogger.logEvent("about_us_click")
            
            case .about:
                router.trigger(.aboutPage)
                EventLogger.logEvent("about_us_click")
            
            case .termsAndConditions:
                router.trigger(.termsAndConditionsPage)
                EventLogger.logEvent("terms_and_conditions_click")
            
            case .privacyPolicy:
                router.trigger(.privacyPolicy)
                EventLogger.logEvent("privacy_policy_click")
            
            case .applyForPremium:
                router.trigger(.premiumPage)
            
            case .logout:
                authUseCase.signOut()
                router.trigger(.logout)
                EventLogger.logEvent("sing_out_click")
            }
    }
}
