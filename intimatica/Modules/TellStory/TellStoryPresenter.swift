//
//  TellStoryPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/18/21.
//

import Foundation

protocol TellStoryViewProtocol: AnyObject {
    func dismiss()
    func dispay(_ error: Error)
}

protocol TellStoryPresenterProtocol {
    func sendButtonDidTap(with story: String, isAllowedToPublish: Bool)
}

final class TellStoryPresenter {
    // MARK: - Properties
    private let router: TellStoryRouter
    private let useCase: GraphQLUseCaseProtocol
    weak var view: TellStoryViewProtocol?
    
    // MARK: - Initializsers
    init(router: TellStoryRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.useCase = dependencies.graphQLUseCase
    }
}

// MARK: - TellStoryPresenterProtocol
extension TellStoryPresenter: TellStoryPresenterProtocol {
    func sendButtonDidTap(with story: String, isAllowedToPublish: Bool) {
        EventLogger.logEvent("send_story_click")
        
        useCase.perform(mutaion: StoryMutation(story: story, isAllowedToPublish: isAllowedToPublish)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                self.router.trigger(.tellStoryThanks)
            case .failure(let error):
                self.view?.dispay(error)
            }
        }
    }
}
