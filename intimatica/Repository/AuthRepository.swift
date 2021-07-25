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
    
    func isEmailValid(_ string: String?) -> Bool
    func isPasswordValid(_ string: String?) -> Bool
}

final class AuthRepository: AuthRepositoryProtocol {
    // MARK: - Properties
    private var networkService: NetworkServiceProtocol!
    private var validatorService: AuthValidatorServiceProtocol!
    
    // MARK: - Initializers
    init(networkService: NetworkServiceProtocol, validatorService: AuthValidatorServiceProtocol) {
        self.networkService = networkService
        self.validatorService = validatorService
    }
    
    func signUp(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        networkService.signUp(email: email, password: password, completionHandler: completionHandler)
    }
    
    func signIn(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        networkService.signIn(email: email, password: password, completionHandler: completionHandler)
    }
    
    func isEmailValid(_ string: String?) -> Bool {
        return validatorService.isEmailValid(string)
    }
    
    func isPasswordValid(_ string: String?) -> Bool {
        return validatorService.isPasswordValid(string)
    }
    
}
