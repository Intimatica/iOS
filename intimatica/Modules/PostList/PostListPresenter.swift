//
//  MainPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation

protocol PostListPresenterProtocol {
    func viewDidLoad()
    func tagFilterButtonDidTap()
    func show(_ post: Post)
    func filter(by category: FeedCategoryFilter)
    func setSelectedTags(_ tags: Set<Int>)
}

protocol PostListViewProtocol: AnyObject {
    func setPosts(_ posts: [Post])
}

final class PostListPresenter {
    // MARK: - Properties
    private var router: Router!
    private var useCase: PostUseCaseProtocol!
    weak var view: PostListViewProtocol?
    
    private var selectedTags: Set<Int> = []
    private var postTypeIdList: [Int] = []

    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol) {
        self.router = router
        useCase = dependencies.postUseCase
    }
}

// MARK: - MainPresenterProtocol
extension PostListPresenter: PostListPresenterProtocol {
    func viewDidLoad() {
        useCase.getPosts(postTypeIdList: postTypeIdList, tagIdList: Array(selectedTags), idList: []) { [weak self] posts in
            self?.view?.setPosts(posts)
        }
    }
    func tagFilterButtonDidTap() {
        router.trigger(.tagCloud(self, selectedTags))
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
    
    func filter(by category: FeedCategoryFilter) {
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
        
        useCase.getPosts(postTypeIdList: postTypeIdList, tagIdList: Array(selectedTags), idList: []) { [weak self] posts in
            self?.view?.setPosts(posts)
        }
    }
    
    func setSelectedTags(_ tags: Set<Int>) {
        selectedTags = tags
        
        useCase.getPosts(postTypeIdList: postTypeIdList, tagIdList: Array(selectedTags), idList: []) { [weak self] posts in
            self?.view?.setPosts(posts)
        }
    }
}
