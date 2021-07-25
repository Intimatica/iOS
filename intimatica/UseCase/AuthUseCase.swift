//
//  AuthUseCase.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/24/21.
//

import Foundation

protocol AuthUseCaseProtocol {
    func signUp(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>)->Void)
    func signIn(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>)->Void)
    
    func isEmailValid(_ string: String?) -> Bool
    func isPasswordValid(_ string: String?) -> Bool
}

final class AuthUseCase: AuthUseCaseProtocol {
    // MARK: - Properties
    private let repository: AuthRepositoryProtocol!
    
    // MARK: - Initializers
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func signUp(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        repository.signUp(email: email, password: password, completionHandler: completionHandler)
    }
    
    func signIn(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        repository.signIn(email: email, password: password, completionHandler: completionHandler)
    }
    
    func isEmailValid(_ string: String?) -> Bool {
        return repository.isEmailValid(string)
    }
    
    func isPasswordValid(_ string: String?) -> Bool {
        return repository.isPasswordValid(string)
    }
    
}
