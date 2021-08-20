//
//  HomeTabCoordinator.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/19/21.
//

import Foundation
import XCoordinator

enum HomeRoute: Route {
    case posts
    case courses
    case profile
}

final class HomeCoordinator: TabBarCoordinator<HomeRoute> {
    // MARK: - Properties
    private let postsRouter: StrongRouter<PostsRoute>
    private let coursesRouter: StrongRouter<PostsRoute>
    private let profileRouter: StrongRouter<ProfileRoute>
    
    
    // MARK: - Initializers
    init(useCaseProvider: UseCaseProviderProtocol) {
        postsRouter = PostsCoordinator(useCaseProvider: useCaseProvider).strongRouter
        coursesRouter = PostsCoordinator(useCaseProvider: useCaseProvider).strongRouter
        profileRouter = ProfileCoordinator(useCaseProvider: useCaseProvider).strongRouter
        
        super.init(initialRoute: .posts)
    }
    
    // MARK: - Overrides
    override func prepareTransition(for route: HomeRoute) -> TabBarTransition {
        switch route {
        case .posts:
            return .multiple(
                .set([postsRouter, coursesRouter, profileRouter]),
                .select(postsRouter)
            )
        case .courses:
            return .select(coursesRouter)
        case .profile:
            return .select(profileRouter)
        }
    }
}
