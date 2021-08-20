//
//  ProfileCoordinator.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/19/21.
//

import Foundation
import XCoordinator

enum ProfileRoute: Route {
    case initial
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
            return .push(viewController)
        }
    }
}
