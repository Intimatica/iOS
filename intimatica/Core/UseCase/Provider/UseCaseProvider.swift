//
//  UseCaseProvider.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation

typealias UseCaseProviderProtocol = HasAuthUseCaseProtocol

final class UseCaseProvider: UseCaseProviderProtocol {
    let authUseCase: AuthUseCaseProtocol
    
    convenience init() {
        self.init(dependencies: RepositoryProvider())
    }
    
    init(dependencies: RepositoryProviderProtocol) {
        authUseCase = AuthUseCase(dependencies: dependencies)
    }
}
