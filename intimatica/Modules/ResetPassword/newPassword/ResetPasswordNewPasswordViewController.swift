//
//  ResetPasswordNewPasswordViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/23/21.
//

import UIKit
import SnapKit

class ResetPasswordNewPasswordViewController: ResetPasswordBaseViewController {
    // MARK: - Properties
    private let presenter: ResetPasswordNewPasswordPresenterDeletage
    
    // MARK: - Initializers
    init(presenter: ResetPasswordNewPasswordPresenterDeletage) {
        self.presenter = presenter
        
        super.init(presenter: presenter)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = Button.backBarButtonItem()
        
        setupView()
        setupConstraints()
        
        newPassword.delegate = self
        confirmPassword.delegate = self
    }
    
    // MARK: - Layout
    private func setupView() {
        subTitleLabel.text = L10n("RESET_PASSWORD_NEW_PASSWORD_PAGE_SUBTITLE")
        actionButton.setTitle(L10n("RESET_PASSWORD_NEW_PASSWORD_PAGE_ACTION_BUTTON_TTTLE"), for: .normal)
        
        containerView.addSubview(newPassword)
        containerView.addSubview(confirmPassword)
        containerView.addSubview(actionButton)
    }
    
    private func setupConstraints() {
        newPassword.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(Constants.passwordViewTop)
        }
        
        confirmPassword.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(newPassword.snp.bottom).offset(Constants.passwordViewTop)
        }
        
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(containerView)
            make.top.equalTo(confirmPassword.snp.bottom).offset(Constants.actionButtonTop)
        }
    }
}

// MARK: - Helper/Constants
extension ResetPasswordNewPasswordViewController {
    struct Constants {
        static let passwordViewTop: CGFloat = 30
        static let actionButtonTop: CGFloat = 40
    }
}

// MARK: - TextFieldViewDelegate
extension ResetPasswordNewPasswordViewController: TextFieldViewDelegate {
    func textFieldEndEditing(_ textFieldView: TextFieldView) {
        if textFieldView == newPassword {
            presenter.validate(field: .newPassword, value: textFieldView.textField.text ?? "")
        } else if textFieldView == confirmPassword {
            presenter.validate(field: .confirmPassword, value: textFieldView.textField.text ?? "")
        }
    }
    
    func textFieldShouldReturn(_ textFieldView: TextFieldView) {
        if textFieldView == newPassword {
            confirmPassword.textField.becomeFirstResponder()
        } else if textFieldView == confirmPassword {
            textFieldView.textField.endEditing(true)
        }
    }
}

// MARK: - ResetPasswordNewPasswordViewControllerDelegate
extension ResetPasswordNewPasswordViewController: ResetPasswordNewPasswordViewControllerDelegate {
    func getNewPassword() -> String {
        newPassword.textField.text ?? ""
    }
    
    func getConfirmPassword() -> String {
        confirmPassword.textField.text ?? ""
    }
}
