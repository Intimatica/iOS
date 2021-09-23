//
//  ResetPasswordCoordinator.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/23/21.
//

import Foundation
import XCoordinator

enum ResetPasswordRoute: Route {
    case initial
    case code
    case newPassword(String)
    case home
    case dismiss
}

class ResetPasswrodCoordinator: NavigationCoordinator<ResetPasswordRoute> {
    private let appRouter: AppRouter
    private let useCaseProvider: UseCaseProviderProtocol
    
    init(appRouter: AppRouter, useCaseProvider: UseCaseProviderProtocol) {
        self.appRouter = appRouter
        self.useCaseProvider = useCaseProvider
        
        super.init(initialRoute: .initial)
    }
    
    override func prepareTransition(for route: ResetPasswordRoute) -> NavigationTransition {
        switch route {
        case .initial:
            let presenter = ResetPasswordEmailPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = ResetPasswordEmailViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
        case .code:
            let presenter = ResetPasswordCodePresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = ResetPasswordCodeViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
        case .newPassword(let code):
            let presenter = ResetPasswordNewPasswordPresenter(router: strongRouter, dependencies: useCaseProvider, code: code)
            let viewController = ResetPasswordNewPasswordViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
        case .home:
            return .multiple(.dismiss(), .trigger(.home, on: appRouter))
        case .dismiss:
            return .dismiss()
        }
        
    }
}
