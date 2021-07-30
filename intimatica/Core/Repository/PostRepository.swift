//
//  PostRepository.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/28/21.
//

import Foundation
import Apollo

protocol PostRepositoryProtocol {
    func getPosts(completionHandler: @escaping ([Post]) -> Void)
    func getTheory(id: Int, completionHandler: @escaping (Result<GraphQLResult<TheoryPostQuery.Data>, Error>) -> Void)
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
    
    func getTheory(id: Int, completionHandler: @escaping (Result<GraphQLResult<TheoryPostQuery.Data>, Error>) -> Void) {
        graphqlService.getTheory(id: id, completionHandler: completionHandler)
    }
}
