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
    
    override func doAuthButtonDidTap(email: String, password: String) {
        networkService.signIn(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let authResponse):
                // GOTO feed
                print(authResponse.jwt)
            case .failure(let authError):
                self.view?.showNotification(self.getLocalizedAuthErrorMessage(from: authError))
            }
        }
    }
}
