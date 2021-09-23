//
//  AgeConfirmPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/22/21.
//

import Foundation
import XCoordinator

protocol AgeConfirmPresenterProtocol {
    func continueButtonDidTap()
    func showTerms()
    func showConditions()
}

final class AgeConfirmPresenter {
    // MARK: - Properties
    private let router: AppRouter!
    
    // MARK: - Initializers
    init(router: AppRouter) {
        self.router = router
    }
}

// MARK: - AgeConfirmPresenterProtocol
extension AgeConfirmPresenter: AgeConfirmPresenterProtocol {
    func showTerms() {
        router.trigger(.terms)
    }
    
    func showConditions() {
        router.trigger(.conditions)
    }
    
    func continueButtonDidTap() {
        router.trigger(.welcome)
    }
}
