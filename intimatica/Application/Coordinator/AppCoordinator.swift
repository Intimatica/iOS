//
//  AppCoordinator.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import Foundation
import XCoordinator

typealias AppRouter = StrongRouter<AppRoute>
typealias FeedRouter = StrongRouter<FeedRoute>
typealias ProfileRouter = StrongRouter<ProfileRoute>
typealias ResetPasswordRouter = StrongRouter<ResetPasswordRoute>

enum AppRoute: Route {
    case launch
    case ageConfirm
    case terms
    case conditions
    case welcome
    case signIn
    case signUp
    case signUpProfile
    case resetPassword
    
    case home

    case dismiss
}

final class AppCoordinator: ViewCoordinator<AppRoute> {
    
    private let useCaseProvider = UseCaseProvider()
    
    init() {
        super.init(rootViewController: UIViewController(), initialRoute: .launch)
//        super.init(rootViewController: UIViewController(), initialRoute: .welcome)
    }
    
    override func prepareTransition(for route: AppRoute) -> ViewTransition {
        switch route {
        
        case .launch:
            let presenter = LaunchPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = LaunchViewController(presenter: presenter)
            viewController.modalPresentationStyle = .fullScreen
            return .show(viewController)
            
        case .ageConfirm:
            let presenter = AgeConfirmPresenter(router: strongRouter)
            let viewController = AgeConfirmViewController(presenter: presenter)
            viewController.modalPresentationStyle = .fullScreen
            return .present(viewController)
        
        case .terms:
            let presenter = WebPagePresenter(dependencies: useCaseProvider, graphQLQuery: TermsQuery())
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)

        case .conditions:
            let presenter = WebPagePresenter(dependencies: useCaseProvider, graphQLQuery: ConditionsQuery())
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
        case .welcome:
            let presenter = WelcomePresenter(router: strongRouter)
            let viewController = WelcomeViewController(presenter: presenter)
            viewController.modalPresentationStyle = .fullScreen
            return .present(viewController)
            
        case .signUp:
            let presenter = SignUpPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = SignUpViewController(presenter: presenter)
            presenter.setView(viewController)
            return .present(viewController)
            
        case .signIn:
            let presenter = SignInPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = SignInViewController(presenter: presenter)
            presenter.setView(viewController)
            return .present(viewController)
            
        case .signUpProfile:
            let presenter = SignUpProfilePresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = SignUpProfileViewController(presenter: presenter)
            presenter.setView(viewController)
            
            let coordinator = HomeCoordinator(useCaseProvider: useCaseProvider, appRouter: strongRouter)
            coordinator.rootViewController.modalPresentationStyle = .fullScreen
            
            return .multiple([.dismiss(), .present(coordinator), .present(viewController)])
            
        case .home:
            let coordinator = HomeCoordinator(useCaseProvider: useCaseProvider, appRouter: strongRouter)
            coordinator.rootViewController.modalPresentationStyle = .fullScreen
            return .present(coordinator)
            
        case .resetPassword:
            let coordinator = ResetPasswrodCoordinator(appRouter: strongRouter, useCaseProvider: useCaseProvider)
            coordinator.rootViewController.modalPresentationStyle = .fullScreen
            return .present(coordinator)

        case .dismiss:
            return .dismiss()
        }
    }
}
