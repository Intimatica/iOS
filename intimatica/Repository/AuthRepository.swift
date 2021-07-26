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
    private var networkService: NetworkServiceProtocol!
    private var keychainService: KeychainService!
    private var validatorService: AuthValidatorServiceProtocol!
    
    // MARK: - Initializers
    init(networkService: NetworkServiceProtocol, keychainService: KeychainService, validatorService: AuthValidatorServiceProtocol) {
        self.networkService = networkService
        self.keychainService = keychainService
        self.validatorService = validatorService
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
