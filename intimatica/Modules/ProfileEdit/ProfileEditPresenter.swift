//
//  ProfileEditPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/17/21.
//

import Foundation

protocol ProfileEditPresenterDelegate: AnyObject {
    func viewDidLoad()
    func saveButtonDidTap()
    func changePasswordButtonDidTap()
}

protocol ProfileEditViewControllerDelegate: AnyObject {
    func setGenderList(_ genderList: [String])
    
    func getNickname() -> String?
    func setNickname(_ nickname: String)
    
    func getGender() -> String?
    func setGender(_ gender: String)
    
    func getBirthDate() -> Date?
    func setBirthDate(_ birthDate: String?)
    
    func displayError(_ message: String)
}

class ProfileEditPresenter {
    // MARK: - Properties
    private let router: ProfileRouter
    private let useCase: GraphQLUseCaseProtocol
    weak var view: ProfileEditViewControllerDelegate?
    private var genders: [ProfileQuery.Data.Gender] = []
    
    // MARK: - Initializers
    init(router: ProfileRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        useCase = dependencies.graphQLUseCase
    }
}

// MARK: - ProfileEditPresenterDelegate
extension ProfileEditPresenter: ProfileEditPresenterDelegate {
    func viewDidLoad() {
        useCase.fetch(query: ProfileQuery()) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                guard
                    let genders = graphQLResult.data?.genders?.compactMap({ $0 }),
                    let profile = graphQLResult.data?.profile,
                    let nickname = profile.nickname
                else {
                    return
                }
                
                self.genders = genders
                let genderList = genders.compactMap({ $0.name })
                self.view?.setGenderList(genderList)
                
                self.view?.setNickname(nickname)
                self.view?.setGender(profile.gender?.name ?? "")
                self.view?.setBirthDate(profile.birthDate)
                
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
    
    func saveButtonDidTap() {
        let nickname = view?.getNickname()
        
        let genderName = view?.getGender() ?? ""
        let genderID = genders.filter {$0.name == genderName}.map {$0.id}.first
        
        let birthDate = view?.getBirthDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let bDate = birthDate == nil ? nil : dateFormatter.string(from: birthDate!)

        useCase.perform(mutaion: UpdateProfileMutation(nickname: nickname, gender: genderID, birthDate: bDate)) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(_):
                self.router.trigger(.back)
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
    
    func changePasswordButtonDidTap() {
        router.trigger(.updatePassword)
    }
}
