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

class WelcomePresenter: WelcomePresenterProtocol {
    typealias Router = StrongRouter<AppRoute>

    let router: Router!
    
    init(router: Router) {
        self.router = router
    }
    
    func singInButtonDidTap() {
        router.trigger(.signIn)
    }
    
    func singUpButtonDidTap() {
        router.trigger(.signUp)
    }
}
