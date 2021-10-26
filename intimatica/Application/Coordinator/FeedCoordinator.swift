//
//  PostsCoordinator.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/19/21.
//

import Foundation
import XCoordinator
import Apollo

enum FeedRoute: Route {
    case feed
    case tagCloud(FeedPresenterDelegate, Set<Int>)
    case notifications
    
    case story(String)
    case theory(String)
    case video(String)
    case videoCourse(String)
    case courseFinished(String, String)

    case tellStory
    
    case helpPage
    case aboutPage
    case termsAndConditionsPage
    case privacyPolicy
    case premiumPage
    case logout
    
    case dismiss
}

final class FeedCoordinator: NavigationCoordinator<FeedRoute> {
    private let useCaseProvider: UseCaseProviderProtocol
    private let feedSettings: FeedSettings
    
    private let appRouter: StrongRouter<AppRoute>
    
    init(useCaseProvider: UseCaseProviderProtocol, feedSettings: FeedSettings, appRouter: StrongRouter<AppRoute>) {
        self.useCaseProvider = useCaseProvider
        self.feedSettings = feedSettings
        
        self.appRouter = appRouter
        
        super.init(initialRoute: .feed)
    }
    
    override func prepareTransition(for route: FeedRoute) -> NavigationTransition {
        switch route {
        case .feed:
            let leftSideMenuPresenter = LeftSideMenuPresenter(router: strongRouter, dependencies: useCaseProvider)
            let leftSideMenuViewController = LeftSideMenuViewController(presenter: leftSideMenuPresenter)
            
            let feedPresenter = FeedPresenter(router: strongRouter, dependencies: useCaseProvider)
            let feedViewController = FeedViewController(presenter: feedPresenter,
                                                        leftSideMenu: leftSideMenuViewController,
                                                        feedSettings: feedSettings)
            feedPresenter.view = feedViewController
            
            return .push(feedViewController)
            
        case .tagCloud(let feedPresenter, let selectedTags):
            let presenter = TagCloudPresenter(router: strongRouter, dependencies: useCaseProvider, feedPresenter: feedPresenter, selectedTags: selectedTags)
            let viewController = TagCloudViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
        case .notifications:
            let presenter = NotificationPresenter(router: strongRouter, dependencies: useCaseProvider)
            let viewController = NotificationViewController(presenter: presenter)
            presenter.view = viewController
            return .push(viewController)
            
        case .story(let id):
            let presenter = StoryPresenter(router: strongRouter, dependencies: useCaseProvider, postId: id)
            let viewController = StoryViewController(presenter: presenter)
            presenter.setView(viewController)
            return .push(viewController)
            
        case .theory(let id):
            let presenter = TheoryPresenter(router: strongRouter, dependencies: useCaseProvider, postId: id)
            let viewController = TheoryViewController(presenter: presenter)
            presenter.setView(viewController)
            return .push(viewController)
            
        case .video(let id):
            let presenter = VideoPresenter(router: strongRouter, dependencies: useCaseProvider, postId: id)
            let viewController = VideoViewController(presenter: presenter)
            presenter.setView(viewController)
            return .push(viewController)
            
        case .videoCourse(let id):
            let presenter = VideoCoursePresenter(router: strongRouter, dependencies: useCaseProvider, postId: id)
            let viewController = VideoCourseViewController(presenter: presenter)
            presenter.setView(viewController)
            return .push(viewController)

        case .courseFinished(let title, let imageUrl):
            let viewController = CourseFinishedViewController(title: title, imageUrl: imageUrl)
            return .present(viewController)
            
        case .tellStory:
            let coordinator = TellStoryCoordinator(useCaseProvider: useCaseProvider)
            coordinator.rootViewController.modalPresentationStyle = .popover
            return .present(coordinator)
        
        case .helpPage:
            let presenter = WebPagePresenter(dependencies: useCaseProvider,
                                             graphQLQuery: HelpPageQuery(locale: AppConstants.language))
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
        case .aboutPage:
            let presenter = WebPagePresenter(dependencies: useCaseProvider, graphQLQuery:
                                                AboutPageQuery(locale: AppConstants.language))
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
        case .termsAndConditionsPage:
            let presenter = WebPagePresenter(dependencies: useCaseProvider,
                                             graphQLQuery: TermsAndConditionsPageQuery(locale: AppConstants.language))
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
        case .privacyPolicy:
            let presenter = WebPagePresenter(dependencies: useCaseProvider,
                                             graphQLQuery: PrivacyPolicyPageQuery(locale: AppConstants.language))
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)
            
        case .premiumPage:
            let presenter = WebPagePresenter(dependencies: useCaseProvider,
                                             graphQLQuery: PremiumDescriptionQuery(locale: AppConstants.language))
            let viewController = WebPageViewController(presenter: presenter)
            presenter.view = viewController
            return .present(viewController)

        case .logout:
//            return .multiple(.dismiss(), .dismiss())
            return .trigger(.ageConfirm, on: appRouter)

        case .dismiss:
            return .dismiss()
        }
    }
}
