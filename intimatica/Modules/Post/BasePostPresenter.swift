//
//  BasePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/2/21.
//

import Foundation

protocol BasePostViewProtocol: AnyObject {
    func setIsFavotire(_ isFavorite: Bool)
}

protocol BasePostPresenterProtocol {
    func viewDidLoad()
    
    func addToFarovites()
    func removeFromFavorites()
}

class BasePostPresenter {
    let router: PostsRouter
    let useCase: PostUseCaseProtocol
    let postId: String
    private weak var view: BasePostViewProtocol?
    
    init(router: PostsRouter, dependencies: UseCaseProviderProtocol, postId: String) {
        self.router = router
        self.useCase = dependencies.postUseCase
        self.postId = postId
    }
    
    func setView(_ view: BasePostViewProtocol) {
        self.view = view
    }
}

// MARK: - BasePresenterProtocol
extension BasePostPresenter: BasePostPresenterProtocol {
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
