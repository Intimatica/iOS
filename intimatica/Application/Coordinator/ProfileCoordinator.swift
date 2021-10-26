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
    case tellStory
    case editProfile
    case updatePassword
    case updateLanguage
    case back
    case dismiss
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
            let presenter = ProfilePresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = ProfileViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
        case .showStory(let story):
            let viewController = UserStoryViewController(story: story)
            return .push(viewController)
        case .premium:
            let presenter = WebPagePresenter(dependencies: useCaseProvider,
                                             graphQLQuery: PremiumDescriptionQuery(locale: AppConstants.language))
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
        case .tellStory:
            let coordinator = TellStoryCoordinator(useCaseProvider: useCaseProvider)
            coordinator.rootViewController.modalPresentationStyle = .popover
            return .present(coordinator)
        case .editProfile:
            let presenter = ProfileEditPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = ProfileEditViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
        case .updatePassword:
            let presenter = UpdatePasswordPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = UpdatePasswordViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
        case .updateLanguage:
            let presenter = LanguageSettingsPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = LanguageSettingsViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
        case .back:
            return .pop()
        case .dismiss:
            return .dismiss()
        }
    }
}
