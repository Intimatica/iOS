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
    func getPosts(postTypeIdList: [Int], tagIdList: [Int], idList: [Int], completionHandler: @escaping ([Post]) -> Void)
    func getPost<T: GraphQLQuery>(query: T, completionHandler: GraphQLResultHandler<T.Data>?)
    func getTags(completionHandler: @escaping TagsCompletionHandler)
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
    
    func getPosts(postTypeIdList: [Int], tagIdList: [Int], idList: [Int], completionHandler: @escaping ([Post]) -> Void) {
        apollo.fetch(query: PostsQuery(postTypeIdList: postTypeIdList, tagIdList: tagIdList, idList: idList)) { [weak self] result in
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
        apollo.fetch(query: query, resultHandler: completionHandler)
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
              let postId = Int(post.id),
              let postTypeString = post.postType?.name,
              let postType = PostType(rawValue: postTypeString),
        
              let imageUrl = post.image?.url,
              let tags = post.tags
        else {
            // TODO: add logger here
            fatalError("Failed to parseGraphQLResult: \(String(describing: post))")
        }
        
        return Post(id: postId,
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
