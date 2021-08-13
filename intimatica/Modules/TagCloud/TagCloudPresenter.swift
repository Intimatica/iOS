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
    private var router: Router!
    private var postUseCase: PostUseCaseProtocol!
    private var postListPresenter: PostListPresenterProtocol!
    private var selectedTags: Set<Int> = []
    weak var view: TagCloudViewProtocol?
    
    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol, postListPresenter: PostListPresenterProtocol, selectedTags: Set<Int>) {
        self.router = router
        self.postUseCase = dependencies.postUseCase
        self.postListPresenter = postListPresenter
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
        postListPresenter.setSelectedTags(selectedTags)
        view?.dismiss()
    }
}
