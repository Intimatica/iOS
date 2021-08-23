//
//  ProfileCoordinator.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/19/21.
//

import Foundation
import XCoordinator
import Apollo

enum ProfileRoute: Route {
    case initial
    case showStory(UserStoriesQuery.Data.Story)
    case premium
}

final class ProfileCoordinator: NavigationCoordinator<ProfileRoute> {
    private let useCaseProvider: UseCaseProviderProtocol
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.useCaseProvider = useCaseProvider
        
        super.init(initialRoute: .initial)
    }
    
    override func prepareTransition(for route: ProfileRoute) -> NavigationTransition {
        switch route {
        case .initial:
            let presenter = ProfilePresenter(router: unownedRouter, dependencies: useCaseProvider)
            let viewController = ProfileViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
        case .showStory(let story):
            let viewController = UserStoryViewController(story: story)
            return .push(viewController)
        case .premium:
            let presenter = WebPagePresenter(dependencies: useCaseProvider, graphQLQuery: PremiumDescriptionQuery())
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
        }
    }
}
