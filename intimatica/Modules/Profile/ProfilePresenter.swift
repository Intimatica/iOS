//
//  ProfilePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/11/21.
//

import Foundation
import XCoordinator

protocol ProfileViewDelegate: AnyObject {
    func setStories(_ stories: [UserStoriesQuery.Data.Story])
}

protocol ProfilePresenterDelegate: AnyObject {
    func viewDidLoad()
    func logoutButtonDidTap()
}

final class ProfilePresenter {
    // MARK: - Properties
    private let router: ProfileRouter
    private let useCase: GraphQLUseCaseProtocol
    weak var view: ProfileViewDelegate?
//    private let authUseCase: AuthUseCaseProtocol
    
    // MARK: - Initializers
    init(router: ProfileRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.useCase = dependencies.graphQLUseCase
    }
}

extension ProfilePresenter: ProfilePresenterDelegate {
    func viewDidLoad() {
        useCase.fetch(query: UserStoriesQuery()) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let stories = graphQLResult.data?.stories?.compactMap({ $0 }) {
                    self.view?.setStories(stories)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logoutButtonDidTap() {
//        authUseCase.signOut()
//        router.trigger(.ageConfirm)
    }
}

