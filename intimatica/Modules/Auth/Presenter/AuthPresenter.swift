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

protocol AuthPresenterDelegate: AnyObject {
    func doAuthButtonDidTap(email : String, password: String)
    func validate(_ field: FieldType, with value: String?)
}

protocol AuthViewDelegate: AnyObject {
    func showValidationError(for field: FieldType, message: String)
    func hideValidationError(for field: FieldType)
    func showNotification(_ message: String)
    func changeAuthButton(isEnabled: Bool)
    func displayError(_ message: String)
}

class AuthPresenter {    
    //MARK: - Properties
    let router: AppRouter
    let useCase: AuthUseCaseProtocol
    let graphQLUseCase: GraphQLUseCaseProtocol
    private weak var view: AuthViewDelegate?

    var emailFieldIsValid = false
    var passwordFieldIsValid = false
    var passwordConfirmFieldIsValid = false
    var passwordValue = ""
    
    // MARK: - Initializers
    init(router: AppRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.useCase = dependencies.authUseCase
        self.graphQLUseCase = dependencies.graphQLUseCase
    }
    
    func setView(_ view: AuthViewDelegate) {
        self.view = view
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
extension AuthPresenter: AuthPresenterDelegate {
    @objc func doAuthButtonDidTap(email: String, password: String) {
    }
}
