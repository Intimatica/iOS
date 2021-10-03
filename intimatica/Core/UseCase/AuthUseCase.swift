//
//  AuthUseCase.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/24/21.
//

import Foundation
import Apollo

protocol AuthUseCaseProtocol {
    func signUp(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>)->Void)
    func signIn(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>)->Void)
    func signOut()
    
    func setAuthToken(_ token: String)
    func perform<T: GraphQLMutation>(mutaion: T, completionHandler: @escaping GraphQLResultHandler<T.Data>)
    
    func getUserCredentials() -> UserCredentials?
    func storeUserCredentials(_ userCredentials: UserCredentials)
    
    func isEmailValid(_ string: String?) -> Bool
    func isPasswordValid(_ string: String?) -> Bool
}

protocol HasAuthUseCaseProtocol {
    var authUseCase: AuthUseCaseProtocol { get }
}

final class AuthUseCase: NSObject, AuthUseCaseProtocol {
    // MARK: - Properties
    private let repository: AuthRepositoryProtocol
    
    // MARK: - Initializers
    init(dependencies: RepositoryProviderProtocol) {
        repository = dependencies.authRepository
    }
    
    func signUp(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        repository.signUp(email: email, password: password, completionHandler: completionHandler)
    }
    
    func signIn(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        repository.signIn(email: email, password: password, completionHandler: completionHandler)
    }
    
    func signOut() {
        repository.signOut()
    }
    
    func setAuthToken(_ token: String) {
        repository.setAuthToken(token)
    }
    
    func perform<T>(mutaion: T, completionHandler: @escaping GraphQLResultHandler<T.Data>) where T : GraphQLMutation {
        repository.perform(mutaion: mutaion, completionHandler: completionHandler)
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


extension AuthUseCase: UIApplicationDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { data in
            String(format: "%02.2hhx", data)
        }.joined()

        print("Device Token: \(token)")
        PushTokenKeeper.sharedInstance.token = token
    }
}
