//
//  SignUpPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/17/21.
//

import Foundation
import XCoordinator

enum FieldType {
    case email
    case password
    case passwordConfirm
}

protocol AuthPresenterProtocol {
    func closeButtonDidTap()
    func doAuthButtonDidTap(email : String, password: String)
    func validate(_ field: FieldType, with value: String?)
}

protocol AuthViewProtocol: AnyObject {
    func showValidationError(for field: FieldType, message: String)
    func hideValidationError(for field: FieldType)
    func showNotification(_ message: String)
    func changeAuthButton(isEnabled: Bool)
}

class AuthPresenter {    
    //MARK: - Properties
    let router: Router!
    weak var view: AuthViewProtocol?
    let useCase: AuthUseCaseProtocol!
    
    var emailFieldIsValid = false
    var passwordFieldIsValid = false
    var passwordConfirmFieldIsValid = false
    var passwordValue = ""
    
    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.useCase = dependencies.authUseCase
    }
    
    func getLocalizedAuthErrorMessage(from authError: AuthError) -> String {
        switch authError {
        case .blocked:
            return L10n("AUTH_ERROR_BLOCKED")
        case .connectionFailed:
            return L10n("AUTH_ERROR_CONNECTION_FAILED")
        case .emailInvalid:
            return L10n("AUTH_ERROR_EMAIL_INVALID")
        case .emailNotConfirmed:
            return L10n("AUTH_ERROR_EMAIL_NOT_CONFIRMED")
        case .emailProvide:
            return L10n("AUTH_ERROR_PROVIDE_EMAIL")
        case .emailTaken:
            return L10n("AUTH_ERROR_EMAIL_TAKEN")
        case .invalid:
            return L10n("AUTH_ERROR_INVALID")
        case .passwordFormat:
            return L10n("AUTH_ERROR_PASSWORD_FORMAT")
        case .passwordLocal:
            return L10n("AUTH_ERROR_PASSWORD_LOCAL")
        case .passwordProvide:
            return L10n("AUTH_ERROR_PASSWORD_PROVIDE")
        case .rateLimit:
            return L10n("AUTH_ERROR_RATE_LIMIT")
        case .userNotExist:
            return L10n("AUTH_ERROR_USER_NOT_EXIST")
        case .usernameTaken:
            return L10n("AUTH_ERROR_USERNAME_TAKEN")
        case .unhandledError(let error):
            return error
        }
    }
    
    func validate(_ field: FieldType, with value: String?) {
        switch field {
        case .email:
            validateEmail(value)
        case .password:
            validatePassword(value)
        case .passwordConfirm:
            validatePasswordConfirm(value)
        }
    }
    
    /*
     TODO: compact this into one func
     */
    
    private func validateEmail(_ string: String?) {
        emailFieldIsValid = useCase.isEmailValid(string)
        
        if emailFieldIsValid {
            view?.hideValidationError(for: .email)
        } else {
            view?.showValidationError(for: .email, message: "AUTH_EMAIL_INVALID")
        }
    }
    
    private func validatePassword(_ string: String?) {
        passwordFieldIsValid = useCase.isPasswordValid(string)
        
        if passwordFieldIsValid {
            // TODO: Unregent fix. Please refactor me
            passwordValue = string ?? ""
            view?.hideValidationError(for: .password)
        } else {
            view?.showValidationError(for: .password, message: "AUTH_PASSWORD_INVALID")
        }
    }
    
    private func validatePasswordConfirm(_ string: String?) {
        passwordConfirmFieldIsValid = string == passwordValue
        
        if passwordConfirmFieldIsValid  {
            view?.hideValidationError(for: .passwordConfirm)
        } else {
            view?.showValidationError(for: .passwordConfirm, message: "AUTH_PASSWORD_CONFIRM_DONT_MATCH")
        }
    }
}

// MARK: - AuthPresenterProtocol
extension AuthPresenter: AuthPresenterProtocol {
    @objc func doAuthButtonDidTap(email: String, password: String) {
    }
    
    func closeButtonDidTap() {
        router.trigger(.dismiss)
    }
}
