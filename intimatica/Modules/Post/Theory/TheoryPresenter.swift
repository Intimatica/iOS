//
//  TheoryPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import Foundation

protocol TheoryPresenterProtocol: BasePostPresenterProtocol {
    func closeButtonDidTap()
}

protocol TheoryViewProtocol: BasePostViewProtocol {
    func display(_ theoryPost: TheoryPostQuery.Data.Post, with webViewSettings: String?)
    func display(_ error: Error)
}

final class TheoryPresenter: BasePostPresenter {
    // MARK: - Properies
    private weak var view: TheoryViewProtocol!
    
    // MARK: - Public
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
                    self.view?.display(theoryPost, with: graphQLResult.data?.webViewSetting?.data)
                }
                // TODO: add else case
            case .failure(let error):
                self.view?.display(error)
            }
        }
    }
}
