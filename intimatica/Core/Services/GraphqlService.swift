//
//  GraphqlService.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation
import Apollo

protocol GraphqlServiceProtocol {
    func getPosts(completionHandler: @escaping ([Post]) -> Void)
}

protocol HasGraphqlServiceProtocol {
    var graphqlService: GraphqlServiceProtocol { get }
}

class GraphqlService: GraphqlServiceProtocol {
    static let shared = GraphqlService()
    
    private(set) lazy var apollo = ApolloClient(
        networkTransport: RequestChainNetworkTransport(
            interceptorProvider: DefaultInterceptorProvider(store: ApolloStore()),
            endpointURL: URL(string: AppConstants.serverURL + "/graphql")!,
            additionalHeaders: ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjI3NDg4NTA1LCJleHAiOjE2MzAwODA1MDV9.47ksZXfznWRythSYY7gECtyu1ODGOXFdsSEjwdodEy4"],
            autoPersistQueries: false,
            requestBodyCreator: ApolloRequestBodyCreator(),
            useGETForQueries: false,
            useGETForPersistedQueryRetry: false),
        store: ApolloStore())
    
    func getPosts(completionHandler: @escaping ([Post]) -> Void) {
        apollo.fetch(query: PostsQuery()) { [weak self] result in
              guard let self = self else { return }
                    
              switch result {
              case .success(let graphQLResult):
                let posts = self.parseGraphQLResult(graphQLResult)
                completionHandler(posts)
              case .failure(let error):
                // TODO: add logger
                print(error.localizedDescription)
                completionHandler([])
              }
          }
    }
    
    private func parseGraphQLResult(_ graphQLResult: GraphQLResult<PostsQuery.Data>) -> [Post] {
        var posts: [Post] = []
        
        graphQLResult.data?.posts?.forEach({ post in
            guard let post = post,
                  let postId = Int(post.id),
                  let postTypeString = post.postType.first??.__typename,
                  let postType = PostType(rawValue: postTypeString),
            
                  let imageUrl = post.image?.url,
                  let tags = post.tags
            else {
                // TODO: add logger here
                print("Failed to parseGraphQLResult: \(graphQLResult)")
                return
            }
            
            posts.append(Post(id: postId,
                              title: post.title,
                              type: postType,
                              imageUrl: imageUrl,
                              tags: tags.compactMap { $0?.name }))
        })
 
        return posts
    }
}
