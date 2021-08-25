//
//  ProfilePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/11/21.
//

import Foundation
import XCoordinator

protocol ProfileViewDelegate: AnyObject {
    func setProfile(email: String, nickname: String?)
    func setStories(_ stories: [UserStoriesQuery.Data.Story])
    func displayError(_ message: String)
}

protocol ProfilePresenterDelegate: AnyObject {
    func viewDidLoad()
    func showStoryButtonDidTap(story: UserStoriesQuery.Data.Story)
    func applyForPremiumButtonDidTap()
    func logoutButtonDidTap()
}

final class ProfilePresenter {
    // MARK: - Properties
    private let router: ProfileRouter
    private let useCase: GraphQLUseCaseProtocol
    private let authUseCase: AuthUseCaseProtocol
    weak var view: ProfileViewDelegate?

    // MARK: - Initializers
    init(router: ProfileRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.useCase = dependencies.graphQLUseCase
        self.authUseCase = dependencies.authUseCase
    }
}

extension ProfilePresenter: ProfilePresenterDelegate {
    func viewDidLoad() {
        if let userCredentials = authUseCase.getUserCredentials() {
            view?.setProfile(email: userCredentials.email, nickname: nil)
        }
        
        useCase.fetch(query: UserStoriesQuery()) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let stories = graphQLResult.data?.stories?.compactMap({ $0 }) {
                    self.view?.setStories(stories)
                } else {
                    self.view?.displayError(graphQLResult.errors?.first?.localizedDescription ?? L10n("UNKNOWN_ERROR_MESSAGE"))
                }
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
    
    func showStoryButtonDidTap(story: UserStoriesQuery.Data.Story) {
        router.trigger(.showStory(story))
    }
    
    func applyForPremiumButtonDidTap() {
        router.trigger(.premium)
    }
    
    func logoutButtonDidTap() {
        authUseCase.signOut()
        router.trigger(.dismiss)
    }
}

