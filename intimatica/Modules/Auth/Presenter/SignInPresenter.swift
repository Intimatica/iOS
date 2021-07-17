//
//  SingInPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import Foundation

protocol  SignInPresenterProtocol: AuthPresenterProtocol {
    func forgotPasswordButtonDidTap()
}

final class SignInPresenter: AuthPresenter {
    
}

// MARK: - SingInPresenterProtocol
extension SignInPresenter: SignInPresenterProtocol {
    func forgotPasswordButtonDidTap() {
        router.trigger(.forgotPassword)
    }
}
