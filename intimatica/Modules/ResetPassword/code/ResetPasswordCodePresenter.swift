//
//  ResetPasswordCodePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/23/21.
//

import Foundation

protocol ResetPasswordCodePresenterDeletage: ResetPasswordBasePresenterDelegate {
    
}

protocol ResetPasswordCodeViewControllerDelegate: ResetPasswordBaseViewControllerDelegate {
    func getCode() -> String
}

class ResetPasswordCodePresenter: ResetPasswordBasePresenter {
    // MARK: - Properties
    weak var view: ResetPasswordCodeViewControllerDelegate?
}

// MARK: - ResetPasswordCodePresenterDeletage
extension ResetPasswordCodePresenter: ResetPasswordCodePresenterDeletage {
    func validate(field: ResetPasswordFieldType, value: String) {
        if !value.isEmpty {
            view?.hideValidationError(for: .code)
            view?.enableActionButton()
        } else {
            view?.showValidationError(for: .code, message: L10n("AUTH_CODE_INVALID"))
            view?.disableActionButton()
        }
    }
    
    func actionButtonDidTap() {
        guard let code = view?.getCode() else { return }
        self.view?.hideSpinner()
        router.trigger(.newPassword(code))
    }
}
