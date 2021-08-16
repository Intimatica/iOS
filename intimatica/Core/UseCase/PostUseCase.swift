//
//  PostUseCase.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/28/21.
//

import Foundation
import Apollo

protocol PostUseCaseProtocol {
    func getPosts(postTypeIdList: [Int], tagIdList: [Int], idList: [Int], completionHandler: @escaping ([Post]) -> Void)
    func getPost<T: GraphQLQuery>(query: T, completionHandler: GraphQLResultHandler<T.Data>?)
    func getTags(completionHandler: @escaping TagsCompletionHandler)
    
    func getFavorites() -> Set<String>
    func addToFavorites(_ id: String)
    func removeFromFavorites(_ id: String)
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
    
    func getPosts(postTypeIdList: [Int], tagIdList: [Int], idList: [Int], completionHandler: @escaping ([Post]) -> Void) {
        postRepository.getPosts(postTypeIdList: postTypeIdList, tagIdList: tagIdList, idList: idList, completionHandler: completionHandler)
    }
    
    func getPost<T : GraphQLQuery>(query: T, completionHandler: GraphQLResultHandler<T.Data>?) {
        postRepository.getPost(query: query, completionHandler: completionHandler)
    }
    
    func getTags(completionHandler: @escaping TagsCompletionHandler) {
        postRepository.getTags(completionHandler: completionHandler)
    }
    
    func getFavorites() -> Set<String> {
        postRepository.getFavorites()
    }
    
    func addToFavorites(_ id: String) {
        postRepository.addToFavorites(id)
    }
    
    func removeFromFavorites(_ id: String) {
        postRepository.removeFromFavorites(id)
    }
}
