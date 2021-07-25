//
//  AuthError.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/25/21.
//

import Foundation

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
