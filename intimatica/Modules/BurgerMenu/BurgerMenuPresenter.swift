//
//  BurgerMenuPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/26/21.
//

import Foundation

protocol BurgerMenuPresenterDelegate: AnyObject {
    
}

final class BurgerMenuPresenter {
    // MARK: - Properties
    let router: FeedRouter
    
    // MARK: - Initializers
    init(router: FeedRouter) {
        self.router = router
    }
}
