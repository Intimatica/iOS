//
//  ProfilePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/11/21.
//

import Foundation

protocol ProfilePresenterProtocol {
    func logoutButtonDidTap()
}

final class ProfilePresenter {
    // MARK: - Properties
    private let router: Router!
    private let authUseCase: AuthUseCaseProtocol!
    
    
    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.authUseCase = dependencies.authUseCase
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func logoutButtonDidTap() {
        authUseCase.signOut()
        router.trigger(.ageConfirm)
    }
}

