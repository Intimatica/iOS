//
//  TagCloudPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/12/21.
//

import Foundation

protocol TagCloudViewProtocol: AnyObject {
    func display(_ tags: [TagsQuery.Data.Tag])
}

protocol TagCloudPresenterProtocol {
    func viewDidLoad()
}

final class TagCloudPresenter {
    // MARK: - Properties
    private var router: Router!
    private var postUseCase: PostUseCaseProtocol!
    weak var view: TagCloudViewProtocol?
    
    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.postUseCase = dependencies.postUseCase
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
                    self.view?.display(tags)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
