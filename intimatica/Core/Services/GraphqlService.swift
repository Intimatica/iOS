//
//  GraphqlService.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation
import Apollo

typealias TagsCompletionHandler = (Result<GraphQLResult<TagsQuery.Data>, Error>) -> Void

protocol GraphqlServiceProtocol {
    func setAuthToken(_ token: String)
    func fetch<T: GraphQLQuery>(query: T, completionHandler: @escaping GraphQLResultHandler<T.Data>)
    func perform<T: GraphQLMutation>(mutaion: T, completionHandler: @escaping GraphQLResultHandler<T.Data>)
    
    func getPosts(postTypeIdList: [Int], tagIdList: [Int], idList: [String], completionHandler: @escaping ([Post]) -> Void)
    func getPost<T: GraphQLQuery>(query: T, completionHandler: GraphQLResultHandler<T.Data>?)
    func getTags(completionHandler: @escaping TagsCompletionHandler)
}

protocol HasGraphqlServiceProtocol {
    var graphqlService: GraphqlServiceProtocol { get }
}

class GraphqlService: GraphqlServiceProtocol {
    private lazy var apollo = ApolloClient(
        networkTransport: RequestChainNetworkTransport(
            interceptorProvider: DefaultInterceptorProvider(store: ApolloStore()),
            endpointURL: URL(string: AppConstants.serverURL + "/graphql")!,
            autoPersistQueries: false,
            requestBodyCreator: ApolloRequestBodyCreator(),
            useGETForQueries: false,
            useGETForPersistedQueryRetry: false),
        store: ApolloStore())
    
    
    // TODO refactor this
    // https://www.apollographql.com/docs/ios/tutorial/tutorial-authentication/#define-login-logic
    func setAuthToken(_ token: String) {
        apollo = ApolloClient(
            networkTransport: RequestChainNetworkTransport(
                interceptorProvider: DefaultInterceptorProvider(store: ApolloStore()),
                endpointURL: URL(string: AppConstants.serverURL + "/graphql")!,
                additionalHeaders: ["Authorization": "Bearer \(token)"],
                autoPersistQueries: false,
                requestBodyCreator: ApolloRequestBodyCreator(),
                useGETForQueries: false,
                useGETForPersistedQueryRetry: false),
            store: ApolloStore())
    }
    
    func fetch<T>(query: T, completionHandler: @escaping GraphQLResultHandler<T.Data>) where T : GraphQLQuery {
        apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData, resultHandler: completionHandler)
    }
    
    func perform<T>(mutaion: T, completionHandler: @escaping GraphQLResultHandler<T.Data>) where T : GraphQLMutation {
        apollo.perform(mutation: mutaion, resultHandler: completionHandler)
    }

    func getPosts(postTypeIdList: [Int], tagIdList: [Int], idList: [String], completionHandler: @escaping ([Post]) -> Void) {
        apollo.fetch(query: PostsQuery(postTypeIdList: postTypeIdList, tagIdList: tagIdList, idList: idList), cachePolicy: .fetchIgnoringCacheData) { [weak self] result in
              guard let self = self else { return }
                    
              switch result {
              case .success(let graphQLResult):
                let posts = self.parseGetPostsGraphQLResult(graphQLResult)
                completionHandler(posts)
              case .failure(let error):
                // TODO: add logger
                print(error.localizedDescription)
                completionHandler([])
              }
          }
    }
    
    func getPost<T: GraphQLQuery>(query: T, completionHandler: GraphQLResultHandler<T.Data>?) {
        apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData, resultHandler: completionHandler)
    }

    private func parseGetPostsGraphQLResult(_ graphQLResult: GraphQLResult<PostsQuery.Data>) -> [Post] {
        var posts: [Post] = []
        
        graphQLResult.data?.posts?.forEach({ post in
            posts.append(PostsQueryData2Post(post: post))
        })
 
        return posts
    }
    
    private func PostsQueryData2Post(post: PostsQuery.Data.Post?) -> Post {
        guard let post = post,
              let postTypeString = post.postType?.name,
              let postType = PostType(rawValue: postTypeString),
        
              let imageUrl = post.image?.url,
              let tags = post.tags
        else {
            // TODO: add logger here
            fatalError("Failed to parseGraphQLResult: \(String(describing: post))")
        }
        
        return Post(id: post.id,
                    title: post.title,
                    type: postType,
                    imageUrl: imageUrl,
                    tags: tags.compactMap { $0?.name },
                    isPaid: post.isPaid)
    }
    
    func getTags(completionHandler: @escaping TagsCompletionHandler) {
        apollo.fetch(query: TagsQuery(), resultHandler: completionHandler)
    }
}
