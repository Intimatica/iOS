//
//  AuthUseCase.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/24/21.
//

import Foundation

protocol AuthRepositoryProtocol {
    func signUp(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>)->Void)
    func signIn(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>)->Void)

    func getUserCredentials() -> UserCredentials?
    func storeUserCredentials(_ userCredentials: UserCredentials)
    
    func isEmailValid(_ string: String?) -> Bool
    func isPasswordValid(_ string: String?) -> Bool
}

final class AuthRepository: AuthRepositoryProtocol {
    
    // MARK: - Properties
    private var networkService: AuthNetworkServiceProtocol!
    private var keychainService: KeychainServiceProtocol!
    private var validatorService: AuthValidatorServiceProtocol!
    
    // MARK: - Initializers
    init(serviceProvider: ServiceProviderProtocol) {
        self.networkService = serviceProvider.authNetworkService
        self.keychainService = serviceProvider.keychainService
        self.validatorService = serviceProvider.authValidatorService
    }
    
    func signUp(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        networkService.signUp(email: email, password: password, completionHandler: completionHandler)
    }
    
    func signIn(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        networkService.signIn(email: email, password: password, completionHandler: completionHandler)
    }
    
    func getUserCredentials() -> UserCredentials? {
        keychainService.getUserCredentials()
    }
    
    func storeUserCredentials(_ userCredentials: UserCredentials) {
        keychainService.storeUserCredentials(userCredentials)
    }
    
    func isEmailValid(_ string: String?) -> Bool {
        return validatorService.isEmailValid(string)
    }
    
    func isPasswordValid(_ string: String?) -> Bool {
        return validatorService.isPasswordValid(string)
    }
}
