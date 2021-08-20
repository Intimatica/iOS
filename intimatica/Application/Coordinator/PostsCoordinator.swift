//
//  PostsCoordinator.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/19/21.
//

import Foundation
import XCoordinator

enum PostsRoute: Route {
    case posts
    
    case tagCloud(PostListPresenterProtocol, Set<Int>)
    
    case story(String)
    case theory(String)
    case video(String)
    case videoCourse(String)
    case courseFinished(String)

    case tellStory
    case tellStoryThanks
}

final class PostsCoordinator: NavigationCoordinator<PostsRoute> {
    private let useCaseProvider: UseCaseProviderProtocol
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.useCaseProvider = useCaseProvider
        
        super.init(initialRoute: .posts)
    }
    
    override func prepareTransition(for route: PostsRoute) -> NavigationTransition {
        switch route {
        case .posts:
            let presenter = PostListPresenter(router: unownedRouter, dependencies: useCaseProvider)
            let viewController = PostListViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
            
        case .tagCloud(let postListPresenter, let selectedTags):
            let presenter = TagCloudPresenter(router: unownedRouter, dependencies: useCaseProvider, postListPresenter: postListPresenter, selectedTags: selectedTags)
            let viewController = TagCloudViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
        case .story(let id):
            let presenter = StoryPresenter(router: unownedRouter, dependencies: useCaseProvider, postId: id)
            let viewController = StoryViewController(presenter: presenter)
            presenter.setView(viewController)
            return .show(viewController)
            
        case .theory(let id):
            let presenter = TheoryPresenter(router: unownedRouter, dependencies: useCaseProvider, postId: id)
            let viewController = TheoryViewController(presenter: presenter)
            presenter.setView(viewController)
            return .show(viewController)
            
        case .video(let id):
            let presenter = VideoPresenter(router: unownedRouter, dependencies: useCaseProvider, postId: id)
            let viewController = VideoViewController(presenter: presenter)
            presenter.setView(viewController)
            return .show(viewController)
            
        case .videoCourse(let id):
            let presenter = VideoCoursePresenter(router: unownedRouter, dependencies: useCaseProvider, postId: id)
            let viewController = VideoCourseViewController(presenter: presenter)
            presenter.setView(viewController)
            return .show(viewController)

        case .courseFinished(let subTitle):
            let viewController = CourseFinishedViewController()
            return .present(viewController)
            
        case .tellStory:
            let presenter = TellStoryPresenter(router: unownedRouter, dependencies: useCaseProvider)
            let viewController = TellStoryViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
        case .tellStoryThanks:
            let viewController = TellStoryThanksViewController()
            return .present(viewController)
        }
    }
}
