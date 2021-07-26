//
//  ValidatorService.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/24/21.
//

import Foundation

protocol AuthValidatorServiceProtocol {
    func isEmailValid(_ string: String?) -> Bool
    func isPasswordValid(_ string: String?) -> Bool
}

protocol HasAuthValidatorServiceProtocol {
    var authValidatorService: AuthValidatorServiceProtocol { get }
}

final class AuthValidatorService: AuthValidatorServiceProtocol {
    static let passwordMinLen = 8
    
    func isEmailValid(_ string: String?) -> Bool {
        guard let string = string else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPredicate.evaluate(with: string)
    }
    
    func isPasswordValid(_ string: String?) -> Bool {
        guard let password = string else { return false }

        return password.count >= AuthValidatorService.passwordMinLen
    }
}
