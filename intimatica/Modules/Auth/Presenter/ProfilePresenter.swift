//
//  File.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/22/21.
//

import Foundation
import XCoordinator

protocol ProfilePresenterProtocol: AuthPresenter {
    func saveButtonDidTap()
    func fillLaterButtonDidTap()
}

final class ProfilePresenter: AuthPresenter {
    
}

// MARK: - ProfilePresenterProtocol
extension ProfilePresenter: ProfilePresenterProtocol {
    func saveButtonDidTap() {
        
    }
    
    func fillLaterButtonDidTap() {
        
    }
}
