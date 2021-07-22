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
}

final class AgeConfirmPresenter {
    typealias Router = StrongRouter<AppRoute>

    // MARK: - Properties
    private let router: Router!
    
    // MARK: - Initializers
    init(router: Router) {
        self.router = router
    }
}

// MARK: - AgeConfirmPresenterProtocol
extension AgeConfirmPresenter: AgeConfirmPresenterProtocol {
    func continueButtonDidTap() {
        router.trigger(.welcome)
    }
}
