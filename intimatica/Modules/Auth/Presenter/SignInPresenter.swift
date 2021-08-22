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
    override func validate(_ field: FieldType, with value: String?) {
        super.validate(field, with: value)
        
        view?.changeAuthButton(isEnabled: emailFieldIsValid && passwordFieldIsValid)
    }
}

// MARK: - SingInPresenterProtocol
extension SignInPresenter: SignInPresenterProtocol {
    func forgotPasswordButtonDidTap() {
//        router.trigger(.forgotPassword)
    }
    
    override func doAuthButtonDidTap(email: String, password: String) {
        useCase.signIn(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let authResponse):
                self.useCase.storeUserCredentials(UserCredentials(email: email, password: password))
                self.useCase.setAuthToken(authResponse.jwt)
                self.router.trigger(.home)
//                self.view?.dismiss()
            case .failure(let authError):
                self.view?.showNotification(self.getLocalizedAuthErrorMessage(from: authError))
            }
        }
    }
}
