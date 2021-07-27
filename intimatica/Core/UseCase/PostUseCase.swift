//
//  PostUseCase.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/28/21.
//

import Foundation

protocol PostUseCaseProtocol {
    func getPosts(completionHandler: @escaping ([Post]) -> Void)
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
}
