//
//  BurgerMenuPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/26/21.
//

import Foundation

enum MenuActionButton {
    case help, about, termsAndConditions, applyForPremium, logout
}

protocol BurgerMenuPresenterDelegate: AnyObject {
    func buttonDidTap(_ button: MenuActionButton)
}

final class BurgerMenuPresenter {
    // MARK: - Properties
    let router: FeedRouter
    
    // MARK: - Initializers
    init(router: FeedRouter) {
        self.router = router
    }
}

extension BurgerMenuPresenter: BurgerMenuPresenterDelegate {
    func buttonDidTap(_ button: MenuActionButton) {
        router.trigger(.help)
    }
}
