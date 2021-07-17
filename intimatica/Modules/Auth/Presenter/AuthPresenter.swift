//
//  SignUpPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import Foundation
import XCoordinator

protocol AuthPresenterProtocol {
    func closeButtonDidTap()
    func authButtoDidTap()
}

class AuthPresenter {
    typealias Router = StrongRouter<AppRoute>
    
    //MARK: - Properties
    let router: Router!
    
    // MARK: - Initializers
    init(router: Router) {
        self.router = router
    }
}

// MARK: - AuthPresenterProtocol
extension AuthPresenter: AuthPresenterProtocol {
    func authButtoDidTap() {
        
    }
    
    func closeButtonDidTap() {
        router.trigger(.dismiss)
    }
}
