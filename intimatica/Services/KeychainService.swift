//
//  StorageService.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/19/21.
//

import Foundation
import KeychainSwift

protocol KeychainServiceProtocol {
    func getUserCredentials() -> UserCredentials?
    func storeUserCredentials(_ userCredentials: UserCredentials)
}

protocol HasKeychainServiceProtocol {
    var keychainService: KeychainServiceProtocol { get }
}

final class KeychainService: KeychainServiceProtocol {
    private let keychain = KeychainSwift()
    private let emailKey = "email"
    private let passwordKey = "password"
    
    func getUserCredentials() -> UserCredentials? {
        guard
            let email = keychain.get(emailKey),
            let password = keychain.get(passwordKey)
        else {
            return nil
        }
        
        return UserCredentials(email: email, password: password)
    }
    
    func storeUserCredentials(_ userCredentials: UserCredentials) {
        keychain.set(userCredentials.email, forKey: emailKey)
        keychain.set(userCredentials.password, forKey: passwordKey)
    }
}
