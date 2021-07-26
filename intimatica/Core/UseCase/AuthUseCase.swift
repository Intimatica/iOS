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

    func getUserCredentials() -> UserCredentials?
    func storeUserCredentials(_ userCredentials: UserCredentials)
    
    func isEmailValid(_ string: String?) -> Bool
    func isPasswordValid(_ string: String?) -> Bool
}

protocol HasAuthUseCaseProtocol {
    var authUseCase: AuthUseCaseProtocol { get }
}

final class AuthUseCase: AuthUseCaseProtocol {
    // MARK: - Properties
    private let repository: AuthRepositoryProtocol!
    
    // MARK: - Initializers
    init(dependencies: RepositoryProviderProtocol) {
        self.repository = dependencies.authRepository
    }
    
    func signUp(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        repository.signUp(email: email, password: password, completionHandler: completionHandler)
    }
    
    func signIn(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        repository.signIn(email: email, password: password, completionHandler: completionHandler)
    }
    
    func getUserCredentials() -> UserCredentials? {
        return repository.getUserCredentials()
    }
    
    func storeUserCredentials(_ userCredentials: UserCredentials) {
        return repository.storeUserCredentials(userCredentials)
    }
    
    func isEmailValid(_ string: String?) -> Bool {
        return repository.isEmailValid(string)
    }
    
    func isPasswordValid(_ string: String?) -> Bool {
        return repository.isPasswordValid(string)
    }
}
