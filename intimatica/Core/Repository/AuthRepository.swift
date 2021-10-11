//
//  AuthUseCase.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/24/21.
//

import Foundation
import Apollo

protocol AuthRepositoryProtocol {
    func signUp(email: String, password: String, completionHandler: @escaping GraphQLResultHandler<SignUpMutation.Data>)
    func signIn(email: String, password: String, completionHandler: @escaping GraphQLResultHandler<SignInMutation.Data>)
    func signOut()
    
    func setAuthToken(_ token: String)
    func perform<T: GraphQLMutation>(mutaion: T, completionHandler: @escaping GraphQLResultHandler<T.Data>)
    
    func getUserCredentials() -> UserCredentials?
    func storeUserCredentials(_ userCredentials: UserCredentials)
    
    func isEmailValid(_ string: String?) -> Bool
    func isPasswordValid(_ string: String?) -> Bool
}

protocol HasAuthRepositoryProtocol {
    var authRepository: AuthRepositoryProtocol { get }
}

final class AuthRepository: AuthRepositoryProtocol {
    
    // MARK: - Properties
    private let graphQLService: GraphqlServiceProtocol
    private let keychainService: KeychainServiceProtocol
    private let validatorService: AuthValidatorServiceProtocol
    
    // MARK: - Initializers
    init(dependencies: ServiceProviderProtocol) {
        graphQLService = dependencies.graphqlService
        keychainService = dependencies.keychainService
        validatorService = dependencies.authValidatorService
    }
    
    func signUp(email: String, password: String, completionHandler: @escaping GraphQLResultHandler<SignUpMutation.Data>) {
        graphQLService.perform(mutaion: SignUpMutation(email: email, password: password), completionHandler: completionHandler)
    }
    
    func signIn(email: String, password: String, completionHandler: @escaping GraphQLResultHandler<SignInMutation.Data>) {
        graphQLService.perform(mutaion: SignInMutation(email: email, password: password), completionHandler: completionHandler)
    }
    
    func signOut() {
        keychainService.deleteUserCredentials()
    }
    
    func setAuthToken(_ token: String) {
        graphQLService.setAuthToken(token)
    }
    
    func perform<T>(mutaion: T, completionHandler: @escaping GraphQLResultHandler<T.Data>) where T : GraphQLMutation {
        graphQLService.perform(mutaion: mutaion, completionHandler: completionHandler)
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
