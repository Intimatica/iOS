//
//  GraphQLUseCase.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/14/21.
//

import Foundation
import Apollo

protocol GraphQLUseCaseProtocol {
    func fetch<T: GraphQLQuery>(query: T, completionHandler: @escaping GraphQLResultHandler<T.Data>)
}

protocol HasGraphQLUseCaseProtocol {
    var graphQLUseCase: GraphQLUseCaseProtocol { get }
}

class GraphQLUseCase: GraphQLUseCaseProtocol {
    private var graphQLRepository: GraphQLRepositoryProtocol!
    
    init(dependencies: RepositoryProviderProtocol) {
        graphQLRepository = dependencies.graphQLRepository
    }
    
    func fetch<T>(query: T, completionHandler: @escaping GraphQLResultHandler<T.Data>) where T : GraphQLQuery {
        graphQLRepository.fetch(query: query, completionHandler: completionHandler)
    }
}
