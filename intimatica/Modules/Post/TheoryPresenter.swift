//
//  TheoryPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import Foundation

protocol TheoryPresenterProtocol {
    func viewDidLoad()
}

protocol TheoryViewProtocol: AnyObject {
    func display(_ theoryPost: TheoryPostQuery.Data.Post)
}

final class TheoryPresenter {
    // MARK: - Properies
    private var router: Router!
    private var useCase: PostUseCaseProtocol!
    private var postId: Int!
    weak var view: TheoryViewProtocol!
    
    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol, postId: Int) {
        self.router = router
        self.useCase = dependencies.postUseCase
        self.postId = postId
    }
}

extension TheoryPresenter: TheoryPresenterProtocol {
    func viewDidLoad() {
        useCase.getTheory(id: postId) { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let graphQLResult):
                if let theoryPost = graphQLResult.data?.post {
                    self.view?.display(theoryPost)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
