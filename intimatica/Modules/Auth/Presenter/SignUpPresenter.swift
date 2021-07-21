//
//  SignUpPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import Foundation

protocol SignUpPresenterProtocol: AuthPresenterProtocol {
    
}

final class SignUpPresenter: AuthPresenter {
    
}

// MARK: - SignUpPresenterProtocol
extension SignUpPresenter: SignUpPresenterProtocol {
    override func doAuthButtonDidTap(email: String, password: String) {
        networkService.signUp(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let authResponse):
                // STORE credentials
                // GOTO Profile page
                print(authResponse.jwt)
            case .failure(let authError):
                self.view?.showNotification(self.getLocalizedAuthErrorMessage(from: authError))
            }
        }
    }
}
