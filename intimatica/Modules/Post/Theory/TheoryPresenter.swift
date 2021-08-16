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

protocol TheoryViewProtocol: BaseViewProtocol {
    func display(_ theoryPost: TheoryPostQuery.Data.Post)
    func display(_ error: Error)
}

final class TheoryPresenter: BasePresenter {
    // MARK: - Properies
    private weak var view: TheoryViewProtocol!
    
    func setView(_ view: TheoryViewProtocol) {
        super.setView(view)
        
        self.view = view
    }
}

extension TheoryPresenter: TheoryPresenterProtocol {
    func closeButtonDidTap() {
//        router.trigger(.home)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useCase.getPost(query: TheoryPostQuery(id: postId)) { [weak self] result in
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
