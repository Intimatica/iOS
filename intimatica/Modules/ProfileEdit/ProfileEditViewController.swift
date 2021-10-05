//
//  ProfileEditViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/17/21.
//

import UIKit
import SnapKit

class ProfileEditViewController: UIViewController {
    // MARK: - Properties
    private let presenter: ProfileEditPresenterDelegate
    
    private lazy var nicknameView = TextFieldView(field: .nickname(
                                                            .settings(placeholder: L10n("PROFILE_NICKNAME_FIELD_TITLE"),  returnKeyType: .next)
    ))
    
    private lazy var genderView = TextFieldView(field: .gender(
                                                            .settings(placeholder: L10n("PROFILE_SEX_FIELD_TITLE"),  returnKeyType: .next)
    ))
    
    private lazy var birthdateView = TextFieldView(field: .birthdate(
                                                            .settings(placeholder: L10n("PROFILE_BIRTHDATE_FIELD_TITLE"),  returnKeyType: .next)
    ))
    
    private lazy var saveButton = UIRoundedButton(title: L10n("PROFILE_SAVE_BUTTON_TITLE"),
                                               titleColor: .white,
                                               font: .rubik(fontSize: .regular, fontWeight: .bold),
                                               backgroundColor: .appDarkPurple)
    
//    private lazy var changePasswordView = ChangePasswordView()
    
    private lazy var backBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "    "
        barButton.tintColor = .appDarkPurple
        return barButton
    }()
    
    // MARK: - Initializers
    init(presenter: ProfileEditPresenterDelegate) {
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
        title = L10n("PROFILE_PAGE_TITLE")
        
        setupView()
        setupConstraints()
        setupActions()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black,
                                                                   NSAttributedString.Key.font: UIFont.rubik(fontSize: .regular, fontWeight: .bold)]
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black,
                                              NSAttributedString.Key.font: UIFont.rubik(fontSize: .regular, fontWeight: .bold)]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black,
                                                                       NSAttributedString.Key.font: UIFont.rubik(fontSize: .regular, fontWeight: .bold)]
        }
    }
    
    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(nicknameView)
        view.addSubview(genderView)
        view.addSubview(birthdateView)
        view.addSubview(saveButton)
//        view.addSubview(changePasswordView)
    }
    
    private func setupConstraints() {
        nicknameView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(Constants.leadingTrailing)
            make.top.equalTo(view).offset(Constants.nicknameViewTop)
        }
        
        genderView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(Constants.leadingTrailing)
            make.top.equalTo(nicknameView.snp.bottom).offset(Constants.genderViewTop)
        }
        
        birthdateView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(Constants.leadingTrailing)
            make.top.equalTo(genderView.snp.bottom).offset(Constants.birthdateView)
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.saveButtonHeight)
            make.leading.trailing.equalTo(view).inset(Constants.leadingTrailing)
            make.top.equalTo(birthdateView.snp.bottom).offset(Constants.saveButtonTop)
        }
        
//        changePasswordView.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(view)
//            make.top.equalTo(saveButton.snp.bottom).offset(Constants.changePasswordViewTop)
//        }
    }
    
    private func setupActions() {
        saveButton.addAction { [weak self] in
            self?.presenter.saveButtonDidTap()
        }
        
//        changePasswordView.actionButton.addAction { [weak self] in
//            self?.presenter.changePasswordButtonDidTap()
//        }
    }
}

// MARK: - Helper/Constants
extension ProfileEditViewController {
    struct Constants {
        static let leadingTrailing: CGFloat = 25
        static let nicknameViewTop: CGFloat = 50
        static let genderViewTop: CGFloat = 30
        static let birthdateView: CGFloat = 30
        static let saveButtonHeight: CGFloat = 50
        static let saveButtonTop: CGFloat = 50
        static let changePasswordViewTop: CGFloat = 60
    }
}

// MARK: - ProfileEditViewControllerDelegate
extension ProfileEditViewController: ProfileEditViewControllerDelegate {
    func getNickname() -> String? {
        nicknameView.textField.text
    }
    
    func getGender() -> String? {
        genderView.textField.text
    }
    
    func getBirthDate() -> Date? {
        let pickerDate = (birthdateView.textField.inputView as? UIDatePicker)?.date
        let birthDateViewText = birthdateView.textField.text ?? ""
        return birthDateViewText.isEmpty ? nil : pickerDate
    }

    func setGenderList(_ genderList: [String]) {
        (genderView.textField.inputView as? PickerKeyboard)?.data = genderList
    }
    
    func setNickname(_ nickname: String) {
        nicknameView.setText(nickname)
    }
    
    func setGender(_ gender: String) {
        genderView.setText(gender)
    }
    
    func setBirthDate(_ birthDate: String?) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let birthDate = birthDate, let date = dateFormatter.date(from:birthDate) {
            (birthdateView.textField.inputView as? UIDatePicker)?.date = date
            birthdateView.setText(localizeDate(birthDate))
        }
    }
    
    func displayError(_ message: String) {
        showError(message)
    }
    
    // TODO: make in localize
    private func localizeDate(_ date: String) -> String {
        let regex = "(\\d+)-(\\d+)-(\\d+)"
        let replaceBy = "$3.$2.$1"
        return date.replacingOccurrences(of: regex, with: replaceBy, options: .regularExpression)
    }
}
