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


final class ServiceProvider: ServiceProviderProtocol {
    let authNetworkService: AuthNetworkServiceProtocol
    let keychainService: KeychainServiceProtocol
    let authValidatorService: AuthValidatorServiceProtocol
    
    init(authNetworkService: AuthNetworkServiceProtocol = AuthNetworkService(),
         keychainService: KeychainServiceProtocol = KeychainService(),
         authValidatorService: AuthValidatorServiceProtocol = AuthValidatorService()
    ) {
        self.authNetworkService = authNetworkService
        self.keychainService = keychainService
        self.authValidatorService = authValidatorService
    }
}
