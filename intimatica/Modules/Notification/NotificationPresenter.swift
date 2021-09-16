//
//  NotificationPresence.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/14/21.
//

import Foundation

protocol NotificationViewControllerDelegate: AnyObject {
    func setNotificatons(_ notifications: [NotificationsQuery.Data.PostNotification])
}

protocol NotificationPresenterDelegate: AnyObject {
    func show(_ post: NotificationsQuery.Data.PostNotification)
    func markAsViewed(_ id: String)
}

class NotificationPresenter {
    private let router: FeedRouter
    private let useCase: PostUseCaseProtocol
    weak var view: NotificationViewControllerDelegate?
    
    init(router: FeedRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.useCase = dependencies.postUseCase
    }
}

// MARK: - NotificationPresenterDelegate
extension NotificationPresenter: NotificationPresenterDelegate {
    func markAsViewed(_ id: String) {
        useCase.addToViewedNotifications(id)
    }

    func show(_ post: NotificationsQuery.Data.PostNotification) {
        guard let postTypeName = post.postType?.name else { return }
        
        switch postTypeName {
        case "Theory":
            router.trigger(.theory(post.id))
        case "Story":
            router.trigger(.story(post.id))
        case "Video":
            router.trigger(.video(post.id))
        case "Course":
            router.trigger(.videoCourse(post.id))
        default:
            print("\(postTypeName) not found")
        }
    }
}

