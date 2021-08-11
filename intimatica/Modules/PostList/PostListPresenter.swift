//
//  MainPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation

protocol PostListPresenterProtocol {
    func viewDidLoad()
    func show(_ post: Post)
    func filter(by category: FeedCategoryFilter, and tags: [Int])
}

protocol PostListViewProtocol: AnyObject {
    func setPosts(_ posts: [Post])
}

final class PostListPresenter {
    // MARK: - Properties
    private var router: Router!
    private var useCase: PostUseCaseProtocol!
    weak var view: PostListViewProtocol?
    
    private let tagsFilterItems: [Int] = []
    private let postTypeFilterItems: [String] = []

    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol) {
        self.router = router
        useCase = dependencies.postUseCase
    }
}

// MARK: - MainPresenterProtocol
extension PostListPresenter: PostListPresenterProtocol {
    func filter(by category: FeedCategoryFilter, and tags: [Int]) {

        var postTypeIdList: [Int] = []
        
        switch category {
        case .theory:
            postTypeIdList = [1]
        case .story:
            postTypeIdList = [2]
        case .video:
            postTypeIdList = [3, 4]
        default:
            break
        }
        
        useCase.getPosts(postTypeIdList: postTypeIdList, tagIdList: tags, idList: []) { [weak self] posts in
            self?.view?.setPosts(posts)
        }
    }
    
    func viewDidLoad() {
        useCase.getPosts(postTypeIdList: [], tagIdList: [], idList: []) { [weak self] posts in
            self?.view?.setPosts(posts)
        }
    }
    
    func show(_ post: Post) {
        switch post.type {
        case .theory:
            router.trigger(.theory(post.id))
        case .video:
            router.trigger(.video(post.id))
        case .videoCourse:
            router.trigger(.videoCourse(post.id))
        default:
            break
        }
    }
}
