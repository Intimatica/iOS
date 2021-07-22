//
//  NetworkService.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/19/21.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    typealias AuthHandler = (Result<AuthResponse, AuthError>)->Void
    
    func signUp(email: String, password: String, completionHandler: @escaping AuthHandler)
    func signIn(email: String, password: String, completionHandler: @escaping AuthHandler)
}

enum AuthError: Error {
    case connectionFailed
    case unhandledError(String)
    
    // auth
    case emailProvide
    case passwordProvide
    case rateLimit
    
    //sign up
    case usernameTaken
    case emailInvalid
    case emailTaken
    case passwordFormat

    
    // sign in
    case invalid
    case blocked
    case passwordLocal
    case userNotExist
    case emailNotConfirmed
}

class AuthNetworkService: NetworkServiceProtocol {
    let headers: HTTPHeaders = [
        "Accept": "application/json"
    ]
    
    // MARK: - signUp
    func signUp(email: String, password: String, completionHandler: @escaping AuthHandler) {
        let url = AppConstants.serverURL + "/auth/local/register"
        let parameters: [String: String] = ["email": email, "password": password]
        
        auth(url: url, parameters: parameters, completionHandler: completionHandler)
    }
    
    // MARK: - signIn
    func signIn(email: String, password: String, completionHandler: @escaping AuthHandler) {
        let url = AppConstants.serverURL + "/auth/local"
        let parameters: [String: String] = ["identifier": email, "password": password]
        
        auth(url: url, parameters: parameters, completionHandler: completionHandler)
    }
        
    // TODO: Fix [String: String] to Parameters
    private func auth(url: String, parameters: [String: String], completionHandler: @escaping AuthHandler) {
            
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
//            .validate(statusCode: 200..<300)
            .responseDecodable(of: AuthResponse.self) { response in
            
            switch response.result {
            
            case .success(let authResponse):
                completionHandler(.success(authResponse))
            
            case .failure(_):
                guard let data = response.data else {
                    return completionHandler(.failure(.connectionFailed))
                }
                
                completionHandler(.failure(self.parseAuthError(from: data)))
            }
        }
    }
    
    private func parseAuthError(from data: Data) -> AuthError {
        do {
            let strapiError = try JSONDecoder().decode(StrapiError.self, from: data)
            
            switch strapiError.message.first?.messages.first?.id {
            // auth
            case "Auth.form.error.ratelimit":
                return .rateLimit
            case "Auth.form.error.email.provide":
                return .emailProvide
            case "Auth.form.error.password.provide":
                return .passwordProvide
                
            // sign up
            case "Auth.form.error.email.invalid":
                return .invalid
            case "Auth.form.error.email.taken":
                return .emailTaken
            case "Auth.form.error.password.format":
                return .passwordFormat
            case "Auth.form.error.username.taken":
                return .usernameTaken
                
            // sign in
            case "Auth.form.error.confirmed":
                return .emailNotConfirmed
            case "Auth.form.error.blocked":
                return .blocked
            case "Auth.form.error.invalid":
                return .invalid
            case "Auth.form.error.password.local":
                return .passwordLocal
            case "Auth.form.error.user.not-exist":
                return .userNotExist
            default:
                return .unhandledError(String(data: data, encoding: .utf8) ?? "")
            }
        } catch {
            // TODO: add crashlytics
            return .unhandledError(String(data: data, encoding: .utf8) ?? "")
        }
    }
}
