//
//  VideoPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/2/21.
//

import Foundation

protocol VideoViewProtocol: AnyObject {
    func display(_ post: VideoPostQuery.Data.Post)
}

protocol VideoPresenterProtocol: BasePresenterProtocol {
}

final class VideoPresenter: BasePresenter {
    // MARK: - Properties
    weak var view: VideoViewProtocol?
}

// MARK: - VideoViewProtocol
extension VideoPresenter: VideoPresenterProtocol {
    func viewDidLoad() {
        useCase.getPost(query: VideoPostQuery(id: postId)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let graphQL):
                if let post = graphQL.data?.post {
                    self.view?.display(post)
                }
                // TODO: add else case
            case .failure(let error):
                print(error)
            }
        }
    }
}
