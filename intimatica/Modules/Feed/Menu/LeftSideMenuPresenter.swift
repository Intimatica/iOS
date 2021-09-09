//
//  BurgerMenuPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/26/21.
//

import Foundation

enum LeftSideMenuActionButton {
    case help, about, termsAndConditions, applyForPremium, logout
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
        case .about:
            router.trigger(.aboutPage)
        case .termsAndConditions:
            router.trigger(.termsAndConditionsPage)
        case .applyForPremium:
            router.trigger(.premiumPage)
        case .logout:
            authUseCase.signOut()
            router.trigger(.logout)
        }
    }
}
