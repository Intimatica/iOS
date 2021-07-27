//
//  MainPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation

protocol PostListPresenterProtocol {
    func viewDidLoad()
}

protocol PostListViewProtocol: AnyObject {
    func setPosts(_ posts: [Post])
}

final class PostListPresenter {
    // MARK: - Properties
    private var router: Router!
    private var useCase: PostUseCaseProtocol!
    weak var view: PostListViewProtocol?

    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol) {
        self.router = router
        useCase = dependencies.postUseCase
    }
}

// MARK: - MainPresenterProtocol
extension PostListPresenter: PostListPresenterProtocol {
    func viewDidLoad() {
        useCase.getPosts { [weak self] posts in
            self?.view?.setPosts(posts)
        }
    }
}
