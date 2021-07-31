//
//  AppCoordinator.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import Foundation
import XCoordinator

typealias Router = StrongRouter<AppRoute>

enum AppRoute: Route {
    case launch
    case ageConfirm
    case welcome
    case signIn
    case signUp
    case logout
    case forgotPassword
    
    case home
    case story(Int)
    case theory(Int)
    case video(Int)
    case videoCourse(Int)
    
    case dismiss
}

final class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    private let useCaseProvider = UseCaseProvider()
    
    init() {
        super.init(initialRoute: .launch)
//        super.init(initialRoute: .theory(7))
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        
        case .launch:
            let presenter = LaunchPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = LaunchViewController(presenter: presenter)
            return .set([viewController])
        
        case .ageConfirm:
            let presenter = AgeConfirmPresenter(router: strongRouter)
            let viewController = AgeConfirmViewController(presenter: presenter)
            return .set([viewController])
        
        case .welcome:
            let presenter = WelcomePresenter(router: strongRouter)
            let viewController = WelcomeViewController(presenter: presenter)
            return .set([viewController])
            
        case .signUp:
            let presenter = SignUpPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = SignUpViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
        case .signIn:
            let presenter = SignInPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = SignInViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
        
        case .home:
            let viewController = HomeTabBarController(router: strongRouter, dependencies: useCaseProvider)
            return .show(viewController)
        
        case .theory(let id):
            let presenter = TheoryPresenter(router: strongRouter, dependencies: useCaseProvider, postId: id)
            let viewController = TheoryViewController(presenter: presenter)
            presenter.view = viewController
            return .show(viewController)
            
        case .dismiss:
            return .dismiss()
        
        default:
            fatalError("in progress")
        }
    }
    
    func configureLauch() {
        
    }
}
