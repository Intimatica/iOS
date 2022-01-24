//
//  TagCloudPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/12/21.
//

import Foundation

protocol TagCloudViewDelegate: AnyObject {
    func display(_ tags: [TagsQuery.Data.Tag], with selectedTags: Set<Int>)
    func displayError(_ text: String)
}

protocol TagCloudPresenterDelegate {
    func viewDidLoad()
    func showButtonDidTap(selectedTags: Set<Int>)
    func clearButtonDidTap()
}

final class TagCloudPresenter {
    // MARK: - Properties
    private let router: FeedRouter
    private let postUseCase: PostUseCaseProtocol
    weak var feedPresenter: FeedPresenterDelegate?
    private var selectedTags: Set<Int> = []
    weak var view: TagCloudViewDelegate?
    
    // MARK: - Initializers
    init(router: FeedRouter, dependencies: UseCaseProviderProtocol, feedPresenter: FeedPresenterDelegate, selectedTags: Set<Int>) {
        self.router = router
        self.postUseCase = dependencies.postUseCase
        self.feedPresenter = feedPresenter
        self.selectedTags = selectedTags
    }
}

// MARK: - TagCloudPresenterProtocol
extension TagCloudPresenter: TagCloudPresenterDelegate {
    func viewDidLoad() {
        postUseCase.getTags { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let tags = graphQLResult.data?.tags?.compactMap({$0}) {
                    print(tags)
                    self.view?.display(tags, with: self.selectedTags)
                } else {
                    self.view?.displayError(graphQLResult.errors?.first?.localizedDescription ?? L10n("UNKNOWN_ERROR_MESSAGE"))
                }
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
    
    func showButtonDidTap(selectedTags: Set<Int>) {
        feedPresenter?.setSelectedTags(selectedTags)
        router.trigger(.dismiss)
        
        EventLogger.logEvent("filter_show_btn_click")
    }
    
    func clearButtonDidTap() {
        feedPresenter?.setSelectedTags(Set<Int>())
        
        EventLogger.logEvent("filter_clear_btn_click")
    }
}
