//
//  RepositoryProvider.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation

typealias RepositoryProviderProtocol = HasAuthRepositoryProtocol

final class RepositoryProvider: RepositoryProviderProtocol {
    let authRepository: AuthRepositoryProtocol
    
    convenience init() {
        self.init(dependencies: ServiceProvider())
    }
    
    init(dependencies: ServiceProviderProtocol) {
        self.authRepository = AuthRepository(dependencies: dependencies)
    }
}
