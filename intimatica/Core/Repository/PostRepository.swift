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
    func getPost<T: GraphQLQuery>(query: T, completionHandler: GraphQLResultHandler<T.Data>?)
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

    func getPost<T>(query: T, completionHandler: GraphQLResultHandler<T.Data>?) where T : GraphQLQuery {
        graphqlService.getPost(query: query, completionHandler: completionHandler)
    }
}
