//
//  LaunchPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import Foundation
import XCoordinator

protocol LaunchPresenterProtocol {
    func viewDidLoad()
}

final class LaunchPresenter {    
    // MARK: - Properties
    private let router: Router
    private let useCase: AuthUseCaseProtocol
    
    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.useCase = dependencies.authUseCase
    }
}

// MARK: - LaunchPresenterProtocol
extension LaunchPresenter: LaunchPresenterProtocol {
    func viewDidLoad() {
        guard let userCredentials = useCase.getUserCredentials() else {
            router.trigger(.ageConfirm)
            return
        }

        useCase.perform(mutaion: SignInMutation(email: userCredentials.email, password: userCredentials.password)) { [weak self] result in
            guard let self = self else { return }

            switch(result) {
            case .success(let graphQLResult):
                if let token = graphQLResult.data?.login.jwt {
                    self.useCase.setAuthToken(token)
                    self.router.trigger(.home)
                } else {
                    self.router.trigger(.ageConfirm)
                }
            case .failure(_):
                self.router.trigger(.ageConfirm)
            }
        }
    }
}
