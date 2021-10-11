//
//  AuthError.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/25/21.
//

import Foundation

struct AuthError: Error {
    var message: String
    
    var localizedDescription: String {
        get {
            L10n(message)
        }
    }
}
