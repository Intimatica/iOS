//
//  TheoryPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import Foundation

protocol TheoryPresenterProtocol: BasePresenterProtocol {
    func closeButtonDidTap()
}

protocol TheoryViewProtocol: AnyObject {
    func display(_ theoryPost: TheoryPostQuery.Data.Post)
    func display(_ error: Error)
}

final class TheoryPresenter: BasePresenter {
    // MARK: - Properies
    weak var view: TheoryViewProtocol!
}

extension TheoryPresenter: TheoryPresenterProtocol {
    func closeButtonDidTap() {
//        router.trigger(.home)
    }
    
    func viewDidLoad() {
        useCase.getPost(query: TheoryPostQuery(id: String(postId))) { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let graphQLResult):
                if let theoryPost = graphQLResult.data?.post {
                    self.view?.display(theoryPost)
                }
                // TODO: add else case
            case .failure(let error):
                self.view?.display(error)
            }
        }
    }
}
