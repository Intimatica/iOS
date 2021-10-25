//
//  LanguageSelectPresenter.swift
//  intimatica
//
//  Created by RustFox on 10/25/21.
//

import Foundation

protocol LanguageSettingsPresenterDeletegate: AnyObject {
    func viewDidLoad()
    func updateCurrentLanguage(to lang: String)
}

protocol LanguageSettingsViewControllerDelegate: AnyObject {
    func setCurrentLanguage(_ lang: String)
    func setLanguages(_ languages: [(code: String, name: String)])
}

class LanguageSettingsPresenter {
    // MARK: - Properties
    private let userDefaultsLangKey = "appLanguage"
    private let languages = [
        (code: "en", name: "Engish"),
        (code: "ru", name: "Русский")
    ]
    private let router: ProfileRouter
    weak var view: LanguageSettingsViewControllerDelegate?
    
    // MARK: - Initializers
    init(router: ProfileRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
    }
}

// MARK: - LanguageSettingsPresenterDeletegate
extension LanguageSettingsPresenter: LanguageSettingsPresenterDeletegate {
    func updateCurrentLanguage(to lang: String) {
        UserDefaults.standard.set(lang, forKey: userDefaultsLangKey)
    }
    
    func viewDidLoad() {
        view?.setLanguages(languages)
        
        var currentLanguage: String = ""
        if let lang = UserDefaults.standard.string(forKey: userDefaultsLangKey) {
            currentLanguage = lang
        } else if let lang = Locale.current.languageCode {
            currentLanguage = lang
        }
        
        currentLanguage = Set(languages.map({$0.code})).contains(currentLanguage) ? currentLanguage : "en"
        view?.setCurrentLanguage(currentLanguage)
    }
}
