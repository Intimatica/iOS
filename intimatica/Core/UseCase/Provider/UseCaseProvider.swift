//
//  UseCaseProvider.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation

typealias UseCaseProviderProtocol = HasAuthUseCaseProtocol
    & HasPostUseCaseProtocol
    & HasGraphQLUseCaseProtocol

final class UseCaseProvider: UseCaseProviderProtocol {
    let authUseCase: AuthUseCaseProtocol
    let postUseCase: PostUseCaseProtocol
    let graphQLUseCase: GraphQLUseCaseProtocol
    
    convenience init() {
        self.init(dependencies: RepositoryProvider())
    }
    
    init(dependencies: RepositoryProviderProtocol) {
        authUseCase = AuthUseCase(dependencies: dependencies)
        postUseCase = PostUseCase(dependencies: dependencies)
        graphQLUseCase = GraphQLUseCase(dependencies: dependencies)
    }
}
