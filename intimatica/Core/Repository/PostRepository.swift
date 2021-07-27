//
//  PostRepository.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/28/21.
//

import Foundation

protocol PostRepositoryProtocol {
    func getPosts(completionHandler: @escaping ([Post]) -> Void)
}

protocol HasPostRepositoryProtocol {
    var postRepository: PostRepositoryProtocol { get }
}

class PostRepository: PostRepositoryProtocol {
    // MARK: - Properties
    private let graphqlService: GraphqlServiceProtocol!
    
    // MARK: - Initializers
    init(dependencies: ServiceProviderProtocol) {
        graphqlService = dependencies.graphqlService
    }
    
    func getPosts(completionHandler: @escaping ([Post]) -> Void) {
        graphqlService.getPosts(completionHandler: completionHandler)
    }
}
