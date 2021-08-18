//
//  StoryPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/17/21.
//

import Foundation

protocol StoryPresenterProtocol: BasePostPresenterProtocol {
    func tellStoryButtonDidTap()
}

protocol StoryViewProtocol: BasePostViewProtocol {
    func display(_ post: StoryPostQuery.Data.Post)
    func display(_ error: Error)
}

final class StoryPresenter: BasePostPresenter {
    // MARK: - Properties
    private weak var view: StoryViewProtocol?
    
    // MARK: - Public
    func setView(_ view: StoryViewProtocol) {
        super.setView(view)
        
        self.view = view
    }
}

// MARK: - StoryPresenterProtocol
extension StoryPresenter: StoryPresenterProtocol {
    override func viewDidLoad() {
        useCase.getPost(query: StoryPostQuery(id: postId)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let post = graphQLResult.data?.post {
                    self.view?.display(post)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tellStoryButtonDidTap() {
        router.trigger(.tellStory)
    }
}
