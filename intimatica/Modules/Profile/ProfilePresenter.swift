//
//  ProfilePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/11/21.
//

import Foundation
import XCoordinator

protocol ProfilePresenterProtocol {
    func logoutButtonDidTap()
}

final class ProfilePresenter {
    // MARK: - Properties
    private let router: ProfileRouter
    private let authUseCase: AuthUseCaseProtocol
    
    // MARK: - Initializers
    init(router: ProfileRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.authUseCase = dependencies.authUseCase
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func logoutButtonDidTap() {
        authUseCase.signOut()
//        router.trigger(.ageConfirm)
    }
}

