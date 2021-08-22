//
//  SignUpPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import Foundation

protocol SignUpPresenterProtocol: AuthPresenterProtocol {
    func accountExistButtonDidTap()
}

final class SignUpPresenter: AuthPresenter {
    override func validate(_ field: FieldType, with value: String?) {
        super.validate(field, with: value)
        
        view?.changeAuthButton(isEnabled: emailFieldIsValid && passwordFieldIsValid && passwordConfirmFieldIsValid)
    }
}

// MARK: - SignUpPresenterProtocol
extension SignUpPresenter: SignUpPresenterProtocol {
    func accountExistButtonDidTap() {
        router.trigger(.signIn)
    }
    
    override func doAuthButtonDidTap(email: String, password: String) {
        useCase.signUp(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let authResponse):
                self.useCase.storeUserCredentials(UserCredentials(email: email, password: password))
                self.view?.dismiss()
                self.useCase.setAuthToken(authResponse.jwt)
                self.router.trigger(.home)
            case .failure(let authError):
                self.view?.showNotification(self.getLocalizedAuthErrorMessage(from: authError))
            }
        }
    }
}
