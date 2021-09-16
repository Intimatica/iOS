//
//  NotificationPresence.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/14/21.
//

import Foundation

protocol NotificationViewControllerDelegate: AnyObject {
    func setNotificatons(_ notifications: [NotificationsQuery.Data.PostNotification])
    func setViewedNotifications(_ viewNotifications: Set<String>)
    func displayError(_ message: String)
}

protocol NotificationPresenterDelegate: AnyObject {
    func viewWillAppear()
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
    func viewWillAppear() {
        let viewedNotifications = useCase.getVieweNotifications()
        view?.setViewedNotifications(viewedNotifications)
        
        useCase.getNotifications { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let notifications = graphQLResult.data?.postNotifications.compactMap({ $0 }) {
                    self.view?.setNotificatons(notifications)
                } else {
                    self.view?.displayError(graphQLResult.errors?.first?.localizedDescription ?? L10n("UNKNOWN_ERROR_MESSAGE"))
                }
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
    
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

