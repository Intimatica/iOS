//
//  ChangePassword.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/22/21.
//

import Foundation

enum UpdatePasswordFieldType {
    case currentPassword
    case newPassword
    case confirmPassword
}

protocol UpdatePasswordPresenterDelegate: AnyObject {
    func validate(field: UpdatePasswordFieldType, with value: String?)
}

protocol UpdatePasswordViewControllerDelegate: AnyObject {
    func getCurrentPassword() -> String?
    func getNewPassword() -> String?
    func getConfirmPassword() -> String?
    
    func showValidationError(for field: UpdatePasswordFieldType, message: String)
    func hideValidationError(for field: UpdatePasswordFieldType)
    
    func enableUpdateButton()
    func disableUpdateButton()
}

class UpdatePasswordPresenter {
    // MARK: - Properties
    private let router: ProfileRouter
    private let useCase: AuthUseCaseProtocol
    weak var view: UpdatePasswordViewControllerDelegate?
    private var currentPasswordIsValid = false
    private var newPasswordIsValid = false
    private var confirmPasswordIsValid = false
    private var passwordValue = ""
    
    // MARK: - Initializers
    init(router: ProfileRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        useCase = dependencies.authUseCase
    }
}

// MARK: - UpdatePasswordPresenterDelegate
extension UpdatePasswordPresenter: UpdatePasswordPresenterDelegate {
    func validate(field: UpdatePasswordFieldType, with value: String?) {
        switch field {
        case .currentPassword:
            currentPasswordIsValid = useCase.isPasswordValid(value)
            if currentPasswordIsValid {
                view?.hideValidationError(for: .currentPassword)
            } else {
                view?.showValidationError(for: .currentPassword, message: "AUTH_PASSWORD_INVALID")
            }
        case .newPassword:
            newPasswordIsValid = useCase.isPasswordValid(value)
            passwordValue = value ?? ""
            if newPasswordIsValid {
                view?.hideValidationError(for: .newPassword)
            } else {
                view?.showValidationError(for: .newPassword, message: "AUTH_PASSWORD_INVALID")
            }
        case .confirmPassword:
            confirmPasswordIsValid = value == passwordValue
            if confirmPasswordIsValid {
                view?.hideValidationError(for: .confirmPassword)
            } else {
                view?.showValidationError(for: .confirmPassword, message: "AUTH_PASSWORD_CONFIRM_DONT_MATCH")
            }
        }
        
        if currentPasswordIsValid && newPasswordIsValid && confirmPasswordIsValid {
            view?.enableUpdateButton()
        } else {
            view?.disableUpdateButton()
        }
    }
}
