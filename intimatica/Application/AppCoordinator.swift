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
    case ageConfirm
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
        super.init(initialRoute: .launch)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        
        case .launch:
            let viewController = LaunchViewController()
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
            let networkService = AuthNetworkService()
            let keychainService = KeychainService()
            let validatorService = AuthValidatorService()
            let repository = AuthRepository(networkService: networkService, keychainService: keychainService, validatorService: validatorService)
            let useCase = AuthUseCase(repository: repository)
            
            let presenter = SignUpPresenter(router: strongRouter, useCase: useCase)
            let viewController = SignUpViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
        case .signIn:
            let networkService = AuthNetworkService()
            let keychainService = KeychainService()
            let validatorService = AuthValidatorService()
            let repository = AuthRepository(networkService: networkService, keychainService: keychainService, validatorService: validatorService)
            let useCase = AuthUseCase(repository: repository)
            
            let presenter = SignInPresenter(router: strongRouter, useCase: useCase)
            let viewController = SignInViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
        
        case .dismiss:
            return .dismiss()
        
        default:
            fatalError("in progress")
        }
    }
    
    func configureLauch() {
        
    }
}
