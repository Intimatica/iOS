//
//  VideoCoursePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/5/21.
//

import Foundation

protocol VideoCourseViewProtocol: BasePostViewProtocol {
    func display(_ reponse: VideoCoursePostQuery.Data)
}

protocol VideoCoursePresenterProtocol: BasePostPresenterProtocol {
    func finishButtonDidTap(finishTitle: String, finishImageUrl: String)
    func applyForPremiumButtonDidTap()
}

final class VideoCoursePresenter: BasePostPresenter {
    // MARK: - Properties
    private weak var view: VideoCourseViewProtocol?
    
    // MARK: - Public
    func setView(_ view: VideoCourseViewProtocol) {
        super.setView(view)
        
        self.view = view
    }
}

// MARK: - VideoCoursePresenterProtocol
extension VideoCoursePresenter: VideoCoursePresenterProtocol {
    func applyForPremiumButtonDidTap() {
        router.trigger(.premiumPage)
    }
    
    func finishButtonDidTap(finishTitle: String, finishImageUrl: String) {
        router.trigger(.courseFinished(finishTitle, finishImageUrl))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useCase.getPost(query: VideoCoursePostQuery(id: postId)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let data = graphQLResult.data {
                    self.view?.display(data)
                }
            case .failure(let error):
                self.view?.display(error)
            }
        }
    }
}
