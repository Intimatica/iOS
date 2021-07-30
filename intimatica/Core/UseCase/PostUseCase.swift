//
//  PostUseCase.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/28/21.
//

import Foundation
import Apollo

protocol PostUseCaseProtocol {
    func getPosts(completionHandler: @escaping ([Post]) -> Void)
    func getTheory(id: Int, completionHandler: @escaping (Result<GraphQLResult<TheoryPostQuery.Data>, Error>) -> Void)
}

protocol HasPostUseCaseProtocol {
    var postUseCase: PostUseCaseProtocol { get }
}

final class PostUseCase: PostUseCaseProtocol {
    // MARK: - Properties
    private let postRepository: PostRepositoryProtocol!
    
    // MARK: - Initializers
    init(dependencies: RepositoryProviderProtocol) {
        postRepository = dependencies.postRepository
    }
    
    func getPosts(completionHandler: @escaping ([Post]) -> Void) {
        postRepository.getPosts(completionHandler: completionHandler)
    }

    func getTheory(id: Int, completionHandler: @escaping (Result<GraphQLResult<TheoryPostQuery.Data>, Error>) -> Void) {
        postRepository.getTheory(id: id, completionHandler: completionHandler)
    }

}
