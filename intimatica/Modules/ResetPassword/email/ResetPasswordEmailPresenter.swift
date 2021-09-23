//
//  ResetPasswordEmailPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/23/21.
//

import Foundation

protocol ResetPasswordEmailPresenterDeletage: ResetPasswordBasePresenterDelegate {
    func dismissButtomDidTap()
}

protocol ResetPasswordEmailViewControllerDelegate: ResetPasswordBaseViewControllerDelegate {
    func getEmail() -> String
}

class ResetPasswordEmailPresenter: ResetPasswordBasePresenter {
    // MARK: - Properties
    weak var view: ResetPasswordEmailViewControllerDelegate?
}

// MARK: - ResetPasswordEmailPresenterDeletage
extension ResetPasswordEmailPresenter: ResetPasswordEmailPresenterDeletage {
    func dismissButtomDidTap() {
        router.trigger(.dismiss)
    }
    
    func validate(field: ResetPasswordFieldType, value: String) {
        if useCase.isEmailValid(value) {
            view?.hideValidationError(for: .email)
            view?.enableActionButton()
        } else {
            view?.showValidationError(for: .email, message: L10n("AUTH_EMAIL_INVALID"))
            view?.disableActionButton()
        }
    }
    
    func actionButtonDidTap() {
        guard let email = view?.getEmail() else { return }

        useCase.perform(mutaion: ForgotPasswordMutation(email: email)) { [weak self] result in
            guard let self = self else { return }

            self.view?.hideSpinner()

            switch result {
            case .success(let graphQLResult):
                if let _ = graphQLResult.data?.forgotPassword?.ok {
                    self.router.trigger(.code)
                } else {
                    self.view?.displayError(message: L10n("AUTH_ERROR_USER_NOT_EXIST"))
                }

            case .failure(let error):
                self.view?.displayError(message: error.localizedDescription)
            }
        }
    }
}
