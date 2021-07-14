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
    case auth
    case signIn
    case signUp
    case logout
    case home
}

class AppListCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .auth)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .auth:
            let viewController = AuthViewController()
            return .show(viewController)
        default:
            fatalError("in progress")
        }
    }
}
