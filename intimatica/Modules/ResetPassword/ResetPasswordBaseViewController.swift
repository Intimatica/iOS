//
//  ResetPasswordBaseViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/22/21.
//

import UIKit
import SnapKit

class ResetPasswordBaseViewController: UIViewController {
    // MARK: - Properties
    private let presenter: ResetPasswordBasePresenterDelegate
        
    lazy var containerView = UIView()
    
    lazy var titleLabel = UILabel(font: .rubik(fontSize: .title, fontWeight: .bold),
                                          textColor: .black,
                                          text: L10n("RESET_PASSWORD_PAGE_TITLE"))
    
    lazy var subTitleLabel = UILabel(font: .rubik(fontSize: .subRegular, fontWeight: .regular),
                                             textColor: .black)
    
    lazy var emailView = TextFieldView(field: .email(
                                                .settings(placeholder: L10n("AUTH_EMAIL_FIELD_PLACEHOLDER"), returnKeyType: .done)))
    
    lazy var codeView = TextFieldView(field: .code(
                                                .settings(placeholder: L10n("AUTH_CODE_FIELD_PLACEHOLDER"), returnKeyType: .done)))
    
    lazy var newPassword = TextFieldView(field: .password(.settings(
                                                                    placeholder: L10n("CHANGE_PASSWORD_NEW_PASSWORD_TITLE"),
                                                                    returnKeyType: .next)))
    
    lazy var confirmPassword = TextFieldView(field: .password(.settings(
                                                                        placeholder: L10n("CHANGE_PASSWORD_CONFIRM_PASSWORD_TITLE"),
                                                                        returnKeyType: .done)))
    
    lazy var actionButton: UIRoundedButton = {
        let button = UIRoundedButton(title: "",
                                     titleColor: .white,
                                     font: .rubik(fontSize: .regular, fontWeight: .bold),
                                     backgroundColor: .appDarkPurple)
        button.setBackgroundColor(.appGray, for: .disabled)
        button.isEnabled = false
        return button
    }()
    
    lazy var backBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "    "
        barButton.tintColor = .appDarkPurple
        return barButton
    }()
    
    // MARK: - Initializers
    
    init(presenter: ResetPasswordBasePresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = backBarButtonItem
        
        setupView()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subTitleLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(Constants.containerViewLeadingTrailing)
            make.centerY.equalTo(view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(containerView)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.subTitleTop)
        }
        
        actionButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.actionButtonHeight)
        }
    }
    
    private func setupActions() {
        actionButton.addAction { [weak self] in
            guard let self = self else { return }
            self.showSpinner(frame: self.view.frame, opacity: 0.5)
            self.presenter.actionButtonDidTap()
        }
    }
}

// MARK: - Helper/Constants
extension ResetPasswordBaseViewController {
    struct Constants {
        static let containerViewLeadingTrailing: CGFloat = 50
        static let subTitleTop: CGFloat = 20
        static let actionButtonHeight: CGFloat = 50
    }
}

// MARK: - ResetPasswordBaseViewControllerDelegate
extension ResetPasswordBaseViewController: ResetPasswordBaseViewControllerDelegate {
    func showValidationError(for field: ResetPasswordFieldType, message: String) {
        hideSpinner()
        
        switch field {
        case .email:
            emailView.showError(message: L10n(message))
        case .code:
            codeView.showError(message: L10n(message))
        case .newPassword:
            newPassword.showError(message: L10n(message))
        case .confirmPassword:
            confirmPassword.showError(message: L10n(message))
        }
    }
    
    func hideValidationError(for field: ResetPasswordFieldType) {
        switch field {
        case .email:
            emailView.hideError()
        case .code:
            codeView.hideError()
        case .newPassword:
            newPassword.hideError()
        case .confirmPassword:
            confirmPassword.hideError()
        }
    }
    
    func enableActionButton() {
        actionButton.isEnabled = true
    }
    
    func disableActionButton() {
        actionButton.isEnabled = false
    }
    
    func displayError(message: String) {
        hideSpinner()
        showError(message)
    }
}
