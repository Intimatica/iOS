//
//  PostRepository.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/28/21.
//

import Foundation
import Apollo

protocol PostRepositoryProtocol {
    func getPosts(postTypeIdList: [Int], tagIdList: [Int], idList: [String], completionHandler: @escaping ([Post]) -> Void)
    func getPost<T: GraphQLQuery>(query: T, completionHandler: GraphQLResultHandler<T.Data>?)
    func getTags(completionHandler: @escaping TagsCompletionHandler)
    func getNotifications(completionHandler: @escaping GraphQLResultHandler<NotificationsQuery.Data>)
    
    func getFavorites() -> Set<String>
    func addToFavorites(_ id: String)
    func removeFromFavorites(_ id: String)
    
    func getVieweNotifications() -> Set<String>
    func addToViewedNotifications(_ id: String)
}

protocol HasPostRepositoryProtocol {
    var postRepository: PostRepositoryProtocol { get }
}

class PostRepository: PostRepositoryProtocol {
    // MARK: - Properties
    private let graphqlService: GraphqlServiceProtocol
    private let favotiresService: FavoritesSeviceProtocol
    private let viewedNotificationsService: ViewedNotificationsServiceProtocol
    
    // MARK: - Initializers
    init(dependencies: ServiceProviderProtocol) {
        graphqlService = dependencies.graphqlService
        favotiresService = dependencies.favoriteService
        viewedNotificationsService = dependencies.viewedNotificationsService
    }

    func getPosts(postTypeIdList: [Int], tagIdList: [Int], idList: [String], completionHandler: @escaping ([Post]) -> Void) {
        graphqlService.getPosts(postTypeIdList: postTypeIdList, tagIdList: tagIdList, idList: idList, completionHandler: completionHandler)
    }

    func getPost<T>(query: T, completionHandler: GraphQLResultHandler<T.Data>?) where T : GraphQLQuery {
        graphqlService.getPost(query: query, completionHandler: completionHandler)
    }
    
    func getTags(completionHandler: @escaping TagsCompletionHandler) {
        graphqlService.getTags(completionHandler: completionHandler)
    }
    
    func getNotifications(completionHandler: @escaping GraphQLResultHandler<NotificationsQuery.Data>) {
        graphqlService.fetch(query: NotificationsQuery(locale: AppConstants.language), completionHandler: completionHandler)
    }
    
    func getFavorites() -> Set<String> {
        favotiresService.get()
    }
    
    func addToFavorites(_ id: String) {
        favotiresService.add(id)
    }
    
    func removeFromFavorites(_ id: String) {
        favotiresService.remove(id)
    }
    
    func getVieweNotifications() -> Set<String> {
        viewedNotificationsService.get()
    }

    func addToViewedNotifications(_ id: String) {
        viewedNotificationsService.add(id)
    }
}
