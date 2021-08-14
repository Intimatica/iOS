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
    case terms
    case conditions
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
    case courseFinished(String)
    
    case playVideo(String)
    
    case tagCloud(PostListPresenterProtocol, Set<Int>)
    
    case profile
    
    case dismiss
}

final class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    private let useCaseProvider = UseCaseProvider()
    
    init() {
        super.init(initialRoute: .launch)
//        super.init(initialRoute: .videoCourse(4))
//        super.init(initialRoute: .courseFinished("hello"))
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
        
        case .terms:
            let presenter = WebPagePresenter(router: strongRouter, dependencies: useCaseProvider, page: .terms)
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)

        case .conditions:
            let presenter = WebPagePresenter(router: strongRouter, dependencies: useCaseProvider, page: .conditions)
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
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
            return .set([viewController])
        
        case .theory(let id):
            let presenter = TheoryPresenter(router: strongRouter, dependencies: useCaseProvider, postId: id)
            let viewController = TheoryViewController(presenter: presenter)
            presenter.view = viewController
            return .show(viewController)
            
        case .video(let id):
            let presenter = VideoPresenter(router: strongRouter, dependencies: useCaseProvider, postId: id)
            let viewController = VideoViewController(presenter: presenter)
            presenter.view = viewController
            return .show(viewController)
            
        case .videoCourse(let id):
            let presenter = VideoCoursePresenter(router: strongRouter, dependencies: useCaseProvider, postId: id)
            let viewController = VideoCourseViewController(presenter: presenter)
            presenter.view = viewController
            return .show(viewController)

        case .courseFinished(let subTitle):
            let viewController = CourseFinishedViewController()
            return .present(viewController)
            
        case .tagCloud(let postListPresenter, let selectedTags):
            let presenter = TagCloudPresenter(router: strongRouter, dependencies: useCaseProvider, postListPresenter: postListPresenter, selectedTags: selectedTags)
            let viewController = TagCloudViewController(presenter: presenter)
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
