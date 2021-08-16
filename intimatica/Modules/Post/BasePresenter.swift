//
//  BasePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/2/21.
//

import Foundation

protocol BaseViewProtocol: AnyObject {
    func setIsFavotire(_ isFavorite: Bool)
}

protocol BasePresenterProtocol {
    func viewDidLoad()
    
    func addToFarovites()
    func removeFromFavorites()
}

class BasePresenter {
    var router: Router!
    var useCase: PostUseCaseProtocol!
    var postId: String!
    private weak var view: BaseViewProtocol?
    
    init(router: Router, dependencies: UseCaseProviderProtocol, postId: String) {
        self.router = router
        self.useCase = dependencies.postUseCase
        self.postId = postId
    }
    
    func setView(_ view: BaseViewProtocol) {
        self.view = view
    }
}

// MARK: - BasePresenterProtocol
extension BasePresenter: BasePresenterProtocol {
    @objc func viewDidLoad() {
        view?.setIsFavotire(useCase.isFavorite(postId))
    }
    
    func addToFarovites() {
        useCase.addToFavorites(postId)
    }
    
    func removeFromFavorites() {
        useCase.removeFromFavorites(postId)
    }
}
