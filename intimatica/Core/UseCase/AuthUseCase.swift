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
    
    func forgotPassword(email: String, completionHandler: @escaping (Result<Void, AuthError>)->Void)
    func resetPasswrod(password: String, passwordConfirm: String, code: String, completionHandler: @escaping (Result<AuthResponse, AuthError>)->Void)
    
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
        repository.signUp(email: email, password: password) { result in
            switch result {
            case .success(let graphQLResult):
                if let register = graphQLResult.data?.register, let jwt = register.jwt {
                    completionHandler(.success(AuthResponse(jwt: jwt, userId: register.user.id, email: register.user.email)))
                } else if let errors = graphQLResult.errors {
                    completionHandler(.failure(self.parseError(errors: errors)))
                } else {
                    completionHandler(.failure(AuthError(message: "UNKNOWN_ERROR")))
                }
            case .failure(let error):
                completionHandler(.failure(AuthError(message: error.localizedDescription)))
            }
        }
    }
    
    func signIn(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        repository.signIn(email: email, password: password) { result in
            switch result {
            case .success(let graphQLResult):
                if let login = graphQLResult.data?.login, let jwt = login.jwt {
                    completionHandler(.success(AuthResponse(jwt: jwt, userId: login.user.id, email: login.user.email)))
                } else if let errors = graphQLResult.errors {
                    completionHandler(.failure(self.parseError(errors: errors)))
                } else {
                    completionHandler(.failure(AuthError(message: "UNKNOWN_ERROR")))
                }
            case .failure(let error):
                completionHandler(.failure(AuthError(message: error.localizedDescription)))
            }
        }
    }
    
    func signOut() {
        repository.setAuthToken("")
        repository.signOut()
    }
    
    func forgotPassword(email: String, completionHandler: @escaping (Result<Void, AuthError>) -> Void) {
        repository.perform(mutaion: ForgotPasswordMutation(email: email)) { result in
            switch result {
            case .success(let graphQLResult):
                if let _ = graphQLResult.data?.forgotPassword?.ok {
                    completionHandler(.success(()))
                } else if let errors = graphQLResult.errors {
                    completionHandler(.failure(self.parseError(errors: errors)))
                } else {
                    completionHandler(.failure(AuthError(message: "UNKNOWN_ERROR")))
                }
            case .failure(let error):
                completionHandler(.failure(AuthError(message: error.localizedDescription)))
            }
        }
    }
    
    func resetPasswrod(password: String,
                       passwordConfirm: String,
                       code: String, completionHandler:
                       @escaping (Result<AuthResponse, AuthError>) -> Void) {
        
        let mutation = ResetPasswordMutation(password: password,
                                             passwordConfirmation: passwordConfirm,
                                             code: code)
        
        repository.perform(mutaion: mutation) { result in
            switch result {
            case .success(let graphQLResult):
                if let resetPassword = graphQLResult.data?.resetPassword, let jwt = resetPassword.jwt {
                    completionHandler(.success(AuthResponse(jwt: jwt, userId: resetPassword.user.id, email: resetPassword.user.email)))
                } else if let errors = graphQLResult.errors {
                    completionHandler(.failure(self.parseError(errors: errors)))
                } else {
                    completionHandler(.failure(AuthError(message: "UNKNOWN_ERROR")))
                }
            case .failure(let error):
                completionHandler(.failure(AuthError(message: error.localizedDescription)))
            }
        }
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
    
    private func parseError(errors: [GraphQLError]) -> AuthError {
        guard let extensions = errors.first?.extensions,
                let exception = extensions["exception"] as? [String: Any],
                let data = exception["data"] as? [String: Any],
                let message = data["message"] as? [Any],
                let firstMessage = message.first as? [String: Any],
                let messages = firstMessage["messages"] as? [Any],
                let resultMessage = messages.first as? [String: Any],
                let messageId = resultMessage["id"] as? String
        else {
            return AuthError(message: "UNKNOWN_ERROR")
        }
                
        return AuthError(message: messageId)
    }
}

// MARK: - UIApplicationDelegate
extension AuthUseCase: UIApplicationDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { data in
            String(format: "%02.2hhx", data)
        }.joined()

        print("Device Token: \(token)")
        PushTokenKeeper.sharedInstance.token = token
    }
}
