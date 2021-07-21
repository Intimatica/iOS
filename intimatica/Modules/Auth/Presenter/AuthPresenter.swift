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
    func authButtoDidTap()
    
    func validate(_ field: FieldType, with value: String?)
}

protocol AuthViewProtocol: AnyObject {
    func showValidationError(for field: FieldType, message: String)
    func hideValidationError(for field: FieldType)
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
}

// MARK: - AuthPresenterProtocol
extension AuthPresenter: AuthPresenterProtocol {
    
    func closeButtonDidTap() {
        router.trigger(.dismiss)
    }
    
    func authButtoDidTap() {
        
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
