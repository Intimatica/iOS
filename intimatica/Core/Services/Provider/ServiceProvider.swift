//
//  ServiceProvider.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import Foundation

typealias ServiceProviderProtocol = HasAuthNetworkServiceProtocol
    & HasKeychainServiceProtocol
    & HasAuthValidatorServiceProtocol
    & HasGraphqlServiceProtocol
    & HasFavoriteServiceProtocol


final class ServiceProvider: ServiceProviderProtocol {
    let authNetworkService: AuthNetworkServiceProtocol
    let keychainService: KeychainServiceProtocol
    let authValidatorService: AuthValidatorServiceProtocol
    let graphqlService: GraphqlServiceProtocol
    let favoriteService: FavoritesSeviceProtocol
    
    init(authNetworkService: AuthNetworkServiceProtocol = AuthNetworkService(),
         keychainService: KeychainServiceProtocol = KeychainService(),
         authValidatorService: AuthValidatorServiceProtocol = AuthValidatorService(),
         graphqlService: GraphqlServiceProtocol = GraphqlService(),
         favoriteService: FavoritesSeviceProtocol = FavoritesSevice()
    ) {
        self.authNetworkService = authNetworkService
        self.keychainService = keychainService
        self.authValidatorService = authValidatorService
        self.graphqlService = graphqlService
        self.favoriteService = favoriteService
    }
}
