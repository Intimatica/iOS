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
    case signIn
    case signUp
    case logout
    case home
}

class AppListCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .home)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .home:
            let viewController = ViewController()
            return .push(viewController)
        default:
            fatalError("in progress")
        }
    }
}
