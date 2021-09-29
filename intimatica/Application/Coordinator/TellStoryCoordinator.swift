//
//  TellStoryCoordinator.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/29/21.
//

import Foundation
import XCoordinator
import Apollo

enum TellStoryRoute: Route {
    case tellStory
    case tellStoryThanks
    case dismiss
}

final class TellStoryCoordinator: NavigationCoordinator<TellStoryRoute> {
    private let useCaseProvider: UseCaseProviderProtocol
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.useCaseProvider = useCaseProvider
        
        super.init(initialRoute: .tellStory)
    }
    
    override func prepareTransition(for route: TellStoryRoute) -> NavigationTransition {
        switch route {
        case .tellStory:
            let presenter = TellStoryPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = TellStoryViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
        case .tellStoryThanks:
            let viewController = TellStoryThanksViewController()
            return .multiple(.dismiss(), .present(viewController))
        case .dismiss:
            return .dismiss()
        }
    }
}
