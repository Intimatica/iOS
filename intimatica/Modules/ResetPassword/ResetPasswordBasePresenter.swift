//
//  ResetPasswordBasePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/22/21.
//

import Foundation

enum ResetPasswordFieldType {
    case email
    case code
    case newPassword
    case confirmPassword
}

protocol ResetPasswordBasePresenterDelegate: AnyObject {
    func validate(field: ResetPasswordFieldType, value: String)
    func actionButtonDidTap()
}

protocol ResetPasswordBaseViewControllerDelegate: AnyObject {
    func showValidationError(for field: ResetPasswordFieldType, message: String)
    func hideValidationError(for field: ResetPasswordFieldType)
    
    func enableActionButton()
    func disableActionButton()
    
    func displayError(message: String)
    func hideSpinner()
}

class ResetPasswordBasePresenter {
    // MARK: - Properties
    let router: ResetPasswordRouter
    let useCase: AuthUseCaseProtocol
    
    // MARK: - Initializers
    init(router: ResetPasswordRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.useCase = dependencies.authUseCase
    }
}
