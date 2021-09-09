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
    private let postsRouter: StrongRouter<FeedRoute>
    private let coursesRouter: StrongRouter<FeedRoute>
    private let profileRouter: StrongRouter<ProfileRoute>
    
    // MARK: - Initializers
    init(useCaseProvider: UseCaseProviderProtocol, appRouter: StrongRouter<AppRoute>) {
        postsRouter = FeedCoordinator(useCaseProvider: useCaseProvider, feedSettings: PostFeedSettings(), appRouter: appRouter).strongRouter
        coursesRouter = FeedCoordinator(useCaseProvider: useCaseProvider, feedSettings: CourseFeedSettings(), appRouter: appRouter).strongRouter
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
