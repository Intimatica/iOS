//
//  ServiceProvider.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import Foundation

typealias ServiceProviderProtocol = HasKeychainServiceProtocol
    & HasAuthValidatorServiceProtocol
    & HasGraphqlServiceProtocol
    & HasFavoriteServiceProtocol
    & HasViewedNotificationsServiceProtocol


final class ServiceProvider: ServiceProviderProtocol {
    let keychainService: KeychainServiceProtocol
    let authValidatorService: AuthValidatorServiceProtocol
    let graphqlService: GraphqlServiceProtocol
    let favoriteService: FavoritesSeviceProtocol
    let viewedNotificationsService: ViewedNotificationsServiceProtocol
    
    init(keychainService: KeychainServiceProtocol = KeychainService(),
         authValidatorService: AuthValidatorServiceProtocol = AuthValidatorService(),
         graphqlService: GraphqlServiceProtocol = GraphqlService(),
         favoriteService: FavoritesSeviceProtocol = FavoritesSevice(),
         viewedNotificationsService: ViewedNotificationsServiceProtocol = ViewedNotificationsService()
    ) {
        self.keychainService = keychainService
        self.authValidatorService = authValidatorService
        self.graphqlService = graphqlService
        self.favoriteService = favoriteService
        self.viewedNotificationsService = viewedNotificationsService
    }
}
