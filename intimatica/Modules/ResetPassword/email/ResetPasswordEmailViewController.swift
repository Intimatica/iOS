//
//  ResetPasswordEmailViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/23/21.
//

import UIKit
import SnapKit

class ResetPasswordEmailViewController: ResetPasswordBaseViewController {
    // MARK: - Properties
    private let presenter: ResetPasswordEmailPresenterDeletage
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = ""
        barButton.tintColor = .appDarkPurple
        barButton.primaryAction = UIAction(image: UIImage(named: "back_button")) { [weak self] _ in
            self?.presenter.dismissButtomDidTap()
        }
        return barButton
    }()
    
    // MARK: - Initializers
    init(presenter: ResetPasswordEmailPresenterDeletage) {
        self.presenter = presenter
        
        super.init(presenter: presenter)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // QUESTION why it breaks view???
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
        
        setupView()
        setupConstraints()
        
        emailView.delegate = self
    }
    
    // MARK: - Layout
    private func setupView() {
        subTitleLabel.text = L10n("RESET_PASSWORD_EMAIL_PAGE_SUBTITLE")
        actionButton.setTitle(L10n("RESET_PASSWORD_EMAIL_PAGE_ACTION_BUTTON_TTTLE"), for: .normal)
        
        containerView.addSubview(emailView)
        containerView.addSubview(actionButton)
    }
    
    private func setupConstraints() {
        emailView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(Constants.emailViewTop)
        }
        
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(containerView)
            make.top.equalTo(emailView.snp.bottom).offset(Constants.actionButtonTop)
        }
    }
}

// MARK: - Helper/Constants
extension ResetPasswordEmailViewController {
    struct Constants {
        static let emailViewTop: CGFloat = 30
        static let actionButtonTop: CGFloat = 40
    }
}

// MARK: - TextFieldViewDelegate
extension ResetPasswordEmailViewController: TextFieldViewDelegate {
    func textFieldEndEditing(_ textFieldView: TextFieldView) {
        presenter.validate(field: .email, value: textFieldView.textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textFieldView: TextFieldView) {
        textFieldView.endEditing(true)
    }
}

// MARK: - ResetPasswordEmailViewControllerDelegate
extension ResetPasswordEmailViewController: ResetPasswordEmailViewControllerDelegate {
    func getEmail() -> String {
        emailView.textField.text ?? ""
    }
}
