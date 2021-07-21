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
}

class AuthPresenter {
    typealias Router = StrongRouter<AppRoute>
    
    //MARK: - Properties
    let router: Router!
    weak var view: AuthViewProtocol?
    let networkService: AuthNetworkService!
    
    // MARK: - Initializers
    init(router: Router, networkService: AuthNetworkService) {
        self.router = router
        self.networkService = networkService
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
}

// MARK: - AuthPresenterProtocol
extension AuthPresenter: AuthPresenterProtocol {
    @objc func doAuthButtonDidTap(email: String, password: String) {
    }
    
    func closeButtonDidTap() {
        router.trigger(.dismiss)
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
    
    private func validateEmail(_ string: String?) {
        if (Validators.isEmailValid(string)) {
            view?.hideValidationError(for: .email)
        } else {
            view?.showValidationError(for: .email, message: "AUTH_EMAIL_INVALID")
        }
    }
    
    private func validatePassword(_ string: String?) {
        if (Validators.isPasswordValid(string)) {
            view?.hideValidationError(for: .password)
        } else {
            view?.showValidationError(for: .password, message: "AUTH_PASSWORD_INVALID")
        }
    }
    
    private func validatePasswordConfirm(_ string: String?) {
        if (Validators.isPasswordValid(string)) {
            view?.hideValidationError(for: .passwordConfirm)
        } else {
            view?.showValidationError(for: .passwordConfirm, message: "AUTH_PASSWORD_CONFIRM_DONT_MATCH")
        }
    }
}

// MARK: - Helper/Validators
struct Validators {
    
    static func isEmailValid(_ string: String?) -> Bool {
        guard let string = string else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPredicate.evaluate(with: string)
    }
    
    static func isPasswordValid(_ password: String?) -> Bool {
        guard let password = password else { return false }

        return password.count >= 8
    }
}
