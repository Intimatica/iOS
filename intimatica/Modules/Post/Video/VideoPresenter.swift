//
//  VideoPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/2/21.
//

import Foundation

protocol VideoViewProtocol: BasePostViewProtocol {
    func display(_ post: VideoPostQuery.Data.Post, with webViewSettings: String?)
}

protocol VideoPresenterProtocol: BasePostPresenterProtocol {
}

final class VideoPresenter: BasePostPresenter {
    // MARK: - Properties
    private weak var view: VideoViewProtocol?
    
    // MARK: - Public
    func setView(_ view: VideoViewProtocol) {
        super.setView(view)
        
        self.view = view
    }
}

// MARK: - VideoViewProtocol
extension VideoPresenter: VideoPresenterProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useCase.getPost(query: VideoPostQuery(id: postId)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQLResult):
                if let post = graphQLResult.data?.post {
                    self.view?.display(post, with: graphQLResult.data?.webViewSetting?.data)
                }
                // TODO: add else case
            case .failure(let error):
                print(error)
            }
        }
    }
}
