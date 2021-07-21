//
//  SignUpPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import Foundation

protocol SignUpPresenterProtocol: AuthPresenterProtocol {
    func doAuthButtonDidTap(email: String, password: String, passwordConfirm: String)
}

final class SignUpPresenter: AuthPresenter {
    
}

// MARK: - SignUpPresenterProtocol
extension SignUpPresenter: SignUpPresenterProtocol {
    func doAuthButtonDidTap(email: String, password: String, passwordConfirm: String) {
        
    }
}
