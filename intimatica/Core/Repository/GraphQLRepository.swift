//
//  GraphQLRepository.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/14/21.
//

import Foundation
import Apollo

protocol GraphQLRepositoryProtocol {
    func fetch<T>(query: T, completionHandler: @escaping GraphQLResultHandler<T.Data>) where T: GraphQLQuery
    func perform<T: GraphQLMutation>(mutaion: T, completionHandler: @escaping GraphQLResultHandler<T.Data>)
}

protocol HasGrapQLRepositoryProtocol {
    var graphQLRepository: GraphQLRepositoryProtocol { get }
}

class GraphQLRepository: GraphQLRepositoryProtocol {
    private let graphQLService: GraphqlServiceProtocol
    
    init(dependencies: ServiceProviderProtocol) {
        graphQLService = dependencies.graphqlService
    }
    
    func fetch<T>(query: T, completionHandler: @escaping (Result<GraphQLResult<T.Data>, Error>) -> Void) where T : GraphQLQuery {
        graphQLService.fetch(query: query, completionHandler: completionHandler)
    }
    
    func perform<T>(mutaion: T, completionHandler: @escaping GraphQLResultHandler<T.Data>) where T : GraphQLMutation {
        graphQLService.perform(mutaion: mutaion, completionHandler: completionHandler)
    }
}
