//
//  TagCloudPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/12/21.
//

import Foundation

protocol TagCloudViewProtocol: AnyObject {
    func display(_ tags: [TagsQuery.Data.Tag], with selectedTags: Set<Int>)
    func dismiss()
}

protocol TagCloudPresenterProtocol {
    func viewDidLoad()
    func showButtonDidTap(selectedTags: Set<Int>)
}

final class TagCloudPresenter {
    // MARK: - Properties
    private let router: PostsRouter
    private let postUseCase: PostUseCaseProtocol
    weak var feedPresenter: FeedPresenterDelegate?
    private var selectedTags: Set<Int> = []
    weak var view: TagCloudViewProtocol?
    
    // MARK: - Initializers
    init(router: PostsRouter, dependencies: UseCaseProviderProtocol, feedPresenter: FeedPresenterDelegate, selectedTags: Set<Int>) {
        self.router = router
        self.postUseCase = dependencies.postUseCase
        self.feedPresenter = feedPresenter
        self.selectedTags = selectedTags
    }
}

// MARK: - TagCloudPresenterProtocol
extension TagCloudPresenter: TagCloudPresenterProtocol {
    func viewDidLoad() {
        postUseCase.getTags { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let tags = graphQLResult.data?.tags?.compactMap({$0}) {
                    self.view?.display(tags, with: self.selectedTags)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showButtonDidTap(selectedTags: Set<Int>) {
        feedPresenter?.setSelectedTags(selectedTags)
        view?.dismiss()
    }
}
