//
//  WelcomePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import Foundation
import XCoordinator

protocol WelcomePresenterProtocol {
    func singInButtonDidTap()
    func singUpButtonDidTap()
}

class WelcomePresenter {
    // MARK: - Properties
    let router: AppRouter!
    
    // MARK: - Initializers
    init(router: AppRouter) {
        self.router = router
    }
}

// MARK: - WelcomePresenterProtocol
extension WelcomePresenter: WelcomePresenterProtocol {
    func singInButtonDidTap() {
        router.trigger(.signIn)
    }
    
    func singUpButtonDidTap() {
        router.trigger(.signUp)
    }
}
