//
//  File.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/22/21.
//

import Foundation
import XCoordinator

protocol SignUpProfilePresenterDelegate: AuthPresenterDelegate {
    func viewDidLoad()
    func saveButtonDidTap(nickname: String?, gender: String?, birthDate: Date?)
}

protocol SignUpProfileViewDelegate: AuthViewDelegate {
    func setGenders(_ genders: [String])
}

final class SignUpProfilePresenter: AuthPresenter {
    private weak var view: SignUpProfileViewDelegate?
    private var genders = [GenderQuery.Data.Gender]()
    
    func setView(_ view: SignUpProfileViewDelegate) {
        super.setView(view)
        
        self.view = view
    }
}

// MARK: - SignUpProfilePresenterProtocol
extension SignUpProfilePresenter: SignUpProfilePresenterDelegate {
    func viewDidLoad() {
        graphQLUseCase.fetch(query: GenderQuery()) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let genders = graphQLResult.data?.genders?.compactMap({$0}) {
                    self.genders = genders
                    self.view?.setGenders(genders.map({L10n($0.name)}))
                } else {
                    self.view?.displayError(graphQLResult.errors?.first?.localizedDescription ?? L10n("UNKNOWN_ERROR_MESSAGE"))
                }
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
    
    func saveButtonDidTap(nickname: String?, gender: String?, birthDate: Date?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let bDate = birthDate == nil ? nil : dateFormatter.string(from: birthDate!)
        
        let genderID = genders.filter {L10n($0.name) == gender ?? "" }.map {$0.id}.first
        
        graphQLUseCase.perform(mutaion: UpdateProfileMutation (nickname: nickname, gender: genderID, birthDate: bDate)) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(_):
                self.router.trigger(.home)
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
}
