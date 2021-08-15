//
//  File.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/22/21.
//

import Foundation
import XCoordinator

protocol SignUpProfilePresenterProtocol: AuthPresenter {
    func saveButtonDidTap(nickname: String?, gender: String?, birthDate: Date?)
}

final class SignUpProfilePresenter: AuthPresenter {
    
}

// MARK: - SignUpProfilePresenterProtocol
extension SignUpProfilePresenter: SignUpProfilePresenterProtocol {
    func saveButtonDidTap(nickname: String?, gender: String?, birthDate: Date?) {
        
    }
}
