//
//  ResetPasswordCodeViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/23/21.
//

import UIKit
import SnapKit

class ResetPasswordCodeViewController: ResetPasswordBaseViewController {
    // MARK: - Properties
    private let presenter: ResetPasswordCodePresenterDeletage
    
    // MARK: - Initializers
    init(presenter: ResetPasswordCodePresenterDeletage) {
        self.presenter = presenter
        
        super.init(presenter: presenter)
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
        
        codeView.delegate = self
    }
    
    // MARK: - Layout
    private func setupView() {
        subTitleLabel.text = L10n("RESET_PASSWORD_CODE_PAGE_SUBTITLE")
        actionButton.setTitle(L10n("RESET_PASSWORD_CODE_PAGE_ACTION_BUTTON_TTTLE"), for: .normal)
        
        containerView.addSubview(codeView)
        containerView.addSubview(actionButton)
    }
    
    private func setupConstraints() {
        codeView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(Constants.codeViewTop)
        }
        
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(containerView)
            make.top.equalTo(codeView.snp.bottom).offset(Constants.actionButtonTop)
        }
    }
}

// MARK: - Helper/Constants
extension ResetPasswordCodeViewController {
    struct Constants {
        static let codeViewTop: CGFloat = 30
        static let actionButtonTop: CGFloat = 40
    }
}

// MARK: - TextFieldViewDelegate
extension ResetPasswordCodeViewController: TextFieldViewDelegate {
    func textFieldEndEditing(_ textFieldView: TextFieldView) {
        presenter.validate(field: .code, value: textFieldView.textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textFieldView: TextFieldView) {
        textFieldView.endEditing(true)
    }
}

// MARK: - ResetPasswordCodeViewControllerDelegate
extension ResetPasswordCodeViewController: ResetPasswordCodeViewControllerDelegate {
    func getCode() -> String {
        codeView.textField.text ?? ""
    }
}
