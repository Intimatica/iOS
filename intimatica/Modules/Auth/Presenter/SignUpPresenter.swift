//
//  SignUpPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import Foundation
import FirebaseAnalytics

protocol SignUpPresenterProtocol: AuthPresenterDelegate {
    func accountExistButtonDidTap()
}

final class SignUpPresenter: AuthPresenter {
    private weak var view: AuthViewDelegate?
    
    override func setView(_ view: AuthViewDelegate) {
        super.setView(view)
        
        self.view = view
    }
    
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
        EventLogger.logEvent("sign_up_click")
        
        useCase.signUp(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let authResponse):
                self.useCase.storeUserCredentials(UserCredentials(email: email, password: password))
                self.useCase.setAuthToken(authResponse.jwt)
                
                FirebaseAnalytics.Analytics.logEvent(AnalyticsEventSignUp, parameters: [:])
                EventLogger.logEvent("sign_up_complete")
                
                self.router.trigger(.signUpProfile)
            case .failure(let authError):
                self.view?.showNotification(authError.localizedDescription)
            }
        }
    }
}
