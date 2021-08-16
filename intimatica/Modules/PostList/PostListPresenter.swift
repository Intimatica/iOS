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
    
    func addToFavorites(_ id: String)
    func removeFromFavotires(_ id: String)
}

protocol PostListViewProtocol: AnyObject {
    func setFavorites(_ favorites: Set<String>)
    func setPosts(_ posts: [Post])
}

final class PostListPresenter {
    // MARK: - Properties
    private var router: Router!
    private var useCase: PostUseCaseProtocol!
    weak var view: PostListViewProtocol?
    
    private var favotires: Set<String> = []
    private var selectedTags: Set<Int> = []
    private var postTypeIdList: [Int] = []
    private var idList: [String] = []

    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol) {
        self.router = router
        useCase = dependencies.postUseCase
    }
}

// MARK: - MainPresenterProtocol
extension PostListPresenter: PostListPresenterProtocol {
    func viewDidLoad() {
        favotires = useCase.getFavorites()
        view?.setFavorites(favotires)
        
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
        idList = []
        
        switch category {
        case .all:
            postTypeIdList = []
        case .theory:
            postTypeIdList = [1]
        case .story:
            postTypeIdList = [2]
        case .video:
            postTypeIdList = [3, 4]
        case .favorite:
            postTypeIdList = []
            idList = Array(favotires)
        }
        
        if category == .favorite && favotires.isEmpty {
            self.view?.setPosts([])
        } else {
            useCase.getPosts(postTypeIdList: postTypeIdList, tagIdList: Array(selectedTags), idList: idList) { [weak self] posts in
                self?.view?.setPosts(posts)
            }
        }
    }
    
    func setSelectedTags(_ tags: Set<Int>) {
        selectedTags = tags
        
        useCase.getPosts(postTypeIdList: postTypeIdList, tagIdList: Array(selectedTags), idList: idList) { [weak self] posts in
            self?.view?.setPosts(posts)
        }
    }
    
    func addToFavorites(_ id: String) {
        favotires.insert(id)
        view?.setFavorites(favotires)
        useCase.addToFavorites(id)
    }
    
    func removeFromFavotires(_ id: String) {
        favotires.remove(id)
        view?.setFavorites(favotires)
        useCase.removeFromFavorites(id)
    }
}
