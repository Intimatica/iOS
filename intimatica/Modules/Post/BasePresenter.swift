//
//  BasePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/2/21.
//

import Foundation

protocol BasePresenterProtocol {
    func viewDidLoad()
}

class BasePresenter {
    var router: Router!
    var useCase: PostUseCaseProtocol!
    var postId: String!
    
    init(router: Router, dependencies: UseCaseProviderProtocol, postId: String) {
        self.router = router
        self.useCase = dependencies.postUseCase
        self.postId = postId
    }
}
