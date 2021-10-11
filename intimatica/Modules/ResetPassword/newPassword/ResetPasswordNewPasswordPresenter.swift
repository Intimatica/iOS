//
//  ResetPasswordNewPasswordPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/23/21.
//

import Foundation

protocol ResetPasswordNewPasswordPresenterDeletage: ResetPasswordBasePresenterDelegate {
    
}

protocol ResetPasswordNewPasswordViewControllerDelegate: ResetPasswordBaseViewControllerDelegate {
    func getNewPassword() -> String
    func getConfirmPassword() -> String
}

class ResetPasswordNewPasswordPresenter: ResetPasswordBasePresenter {
    // MARK: - Properties
    private let code: String
    private var newPasswordIsValid = false
    private var confirmPasswordIsValid = false
    private var passwordValue = ""
    weak var view: ResetPasswordNewPasswordViewControllerDelegate?
    
    init(router: ResetPasswordRouter, dependencies: UseCaseProviderProtocol, code: String) {
        self.code = code
        super.init(router: router, dependencies: dependencies)
    }
}

// MARK: - ResetPasswordNewPasswordPresenterDeletage
extension ResetPasswordNewPasswordPresenter: ResetPasswordNewPasswordPresenterDeletage {
    func validate(field: ResetPasswordFieldType, value: String) {
        if field == .newPassword {
            newPasswordIsValid = useCase.isPasswordValid(value)
            if newPasswordIsValid {
                passwordValue = value
                view?.hideValidationError(for: .newPassword)
            } else {
                view?.showValidationError(for: .newPassword, message: "AUTH_PASSWORD_INVALID")
            }
        } else if field == .confirmPassword {
            confirmPasswordIsValid = value == passwordValue
            if confirmPasswordIsValid {
                view?.hideValidationError(for: .confirmPassword)
            } else {
                view?.showValidationError(for: .confirmPassword, message: "AUTH_PASSWORD_CONFIRM_DONT_MATCH")
            }
        }

        if newPasswordIsValid && confirmPasswordIsValid {
            view?.enableActionButton()
        } else {
            view?.disableActionButton()
        }
    }
    
    func actionButtonDidTap() {
        guard
            let newPassword = view?.getNewPassword(),
            let confirmPassword = view?.getConfirmPassword()
        else { return }
        
        useCase.resetPasswrod(password: newPassword, passwordConfirm: confirmPassword, code: code) { [weak self] result in
            guard let self = self else { return }

            self.view?.hideSpinner()

            switch result {
            case .success(let authResponse):
                self.useCase.setAuthToken(authResponse.jwt)
                self.useCase.storeUserCredentials(UserCredentials(email: authResponse.email, password: newPassword))
                self.router.trigger(.home)
            case .failure(let error):
                self.view?.displayError(message: error.localizedDescription)
            }
        }
    }
}
