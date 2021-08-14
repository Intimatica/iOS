//
//  RepositoryProvider.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation

typealias RepositoryProviderProtocol = HasAuthRepositoryProtocol
    & HasPostRepositoryProtocol
    & HasGrapQLRepositoryProtocol

final class RepositoryProvider: RepositoryProviderProtocol {    
    let authRepository: AuthRepositoryProtocol
    let postRepository: PostRepositoryProtocol
    let graphQLRepository: GraphQLRepositoryProtocol
    
    convenience init() {
        self.init(dependencies: ServiceProvider())
    }
    
    init(dependencies: ServiceProviderProtocol) {
        authRepository = AuthRepository(dependencies: dependencies)
        postRepository = PostRepository(dependencies: dependencies)
        graphQLRepository = GraphQLRepository(dependencies: dependencies)
    }
}
