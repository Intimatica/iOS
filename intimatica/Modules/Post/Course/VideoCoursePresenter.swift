//
//  VideoCoursePresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/5/21.
//

import Foundation

protocol VideoCourseViewProtocol: BasePostViewProtocol {
    func display(_ post: VideoCoursePostQuery.Data.Post, with webViewSettings: String?)
}

protocol VideoCoursePresenterProtocol: BasePostPresenterProtocol {
    func finishButtonDidTap()
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
    func finishButtonDidTap() {
        router.trigger(.courseFinished("hello"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useCase.getPost(query: VideoCoursePostQuery(id: postId)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let post = graphQLResult.data?.post {
                    self.view?.display(post, with: graphQLResult.data?.webViewSetting?.data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
