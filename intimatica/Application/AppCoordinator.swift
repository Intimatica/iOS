//
//  AppCoordinator.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import Foundation
import XCoordinator

enum AppRoute: Route {
    case launch
    case welcome
    case signIn
    case signUp
    case logout
    case home
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .welcome)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        
        case .welcome:
            let presenter = WelcomePresenter(router: strongRouter)
            let viewController = WelcomeViewController(presenter: presenter)
            return .push(viewController)
            
        case .signUp:
            let viewController = SignUpViewController()
            return .push(viewController)
            
        default:
            fatalError("in progress")
        }
    }
}
