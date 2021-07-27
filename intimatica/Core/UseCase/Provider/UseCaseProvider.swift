//
//  UseCaseProvider.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation

typealias UseCaseProviderProtocol = HasAuthUseCaseProtocol
    & HasPostUseCaseProtocol

final class UseCaseProvider: UseCaseProviderProtocol {
    let authUseCase: AuthUseCaseProtocol
    let postUseCase: PostUseCaseProtocol
    
    convenience init() {
        self.init(dependencies: RepositoryProvider())
    }
    
    init(dependencies: RepositoryProviderProtocol) {
        authUseCase = AuthUseCase(dependencies: dependencies)
        postUseCase = PostUseCase(dependencies: dependencies)
    }
}
