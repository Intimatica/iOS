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
    case forgotPassword
    case home
    case dismiss
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
            let presenter = SignUpPresenter(router: strongRouter)
            let viewController = SignUpViewController(presenter: presenter)
            return .present(viewController)
            
        case .signIn:
            let presenter = SignInPresenter(router: strongRouter)
            let viewController = SignInViewController(presenter: presenter)
            return .present(viewController)
        
        case .dismiss:
            return .dismiss()
        
        default:
            fatalError("in progress")
        }
    }
}
