//
//  ProfileViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/22/21.
//

import UIKit

class SignUpProfileViewController: AuthViewController {
    // MARK: - Properties
    private var presenter: SignUpProfilePresenterProtocol!
    
    lazy var fillLateButton: UIButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .rubik(fontWeight: .medium)
        button.setTitleColor(.appPurple, for: .normal)
        button.setTitle(L10n("PROFILE_FILL_LATER_BUTTON_TITLE"), for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.appPurple.cgColor
        return button
    }()
    
    // MARK: - Initializers
    init(presenter: SignUpProfilePresenterProtocol) {
        super.init(presenter: presenter)
        
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameView.delegate = self
        genderView.delegate = self
        birthdateView.delegate = self
        
        setupView()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Layout
    private func setupView() {
        titleLabel.text = L10n("PROFILE_VIEW_TITLE")
        authButton.setTitle(L10n("PROFILE_SAVE_BUTTON_TITLE"), for: .normal)
        
        stackView.addArrangedSubview(nicknameView)
        stackView.addArrangedSubview(genderView)
        stackView.addArrangedSubview(birthdateView)
        
        view.addSubview(fillLateButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            fillLateButton.topAnchor.constraint(equalTo: authButton.bottomAnchor, constant: 20),
            fillLateButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            fillLateButton.heightAnchor.constraint(equalTo: authButton.heightAnchor),
            fillLateButton.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func setupActions() {
        fillLateButton.addAction { [weak self] in
            self?.dismiss()
        }
        
        authButton.addAction { [weak self] in
            guard
                let self = self,
                let nickname = self.nicknameView.textField.text,
                let gender = self.genderView.textField.text,
                let birthDate = (self.birthdateView.textField.inputView as? UIDatePicker)?.date
            else {
                return
            }
            
            self.presenter.saveButtonDidTap(nickname: nickname, gender: gender, birthDate: birthDate)
        }
    }
}

// MARK: - TextFieldViewDelegate
extension SignUpProfileViewController {
    override func textFieldEndEditing(_ textFieldView: TextFieldView) {
        guard
            let nickname = nicknameView.textField.text,
            let gender = genderView.textField.text,
            let birthDate = birthdateView.textField.text
        else {
            return
        }
        
        authButton.isEnabled = !nickname.isEmpty || !gender.isEmpty || !birthDate.isEmpty
    }
    
    override func textFieldShouldReturn(_ textFieldView: TextFieldView) {
        if textFieldView == nicknameView {
            genderView.textField.becomeFirstResponder()
        } else if textFieldView == genderView {
            birthdateView.textField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
}
