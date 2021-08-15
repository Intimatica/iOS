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
        
        setupView()
        setupConstraints()
        setupActions()
        
//        genderPicker = PickerView()
////        genderPicker.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        genderPicker.data = ["Male", "Female", "Other", "I don't know"]
//        genderView.textField.inputView = genderPicker
//        genderView.textField.inputAccessoryView = genderPicker.inputAccessoryView
    }
    
    // MARK: - Layout
    private func setupView() {
        titleLabel.text = L10n("PROFILE_VIEW_TITLE")
        
        stackView.addArrangedSubview(nicknameView)
        stackView.addArrangedSubview(genderView)
        stackView.addArrangedSubview(birthdateView)
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupActions() {
        
    }
}
