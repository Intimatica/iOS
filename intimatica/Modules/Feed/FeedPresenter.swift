//
//  MainPresenter.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/27/21.
//

import Foundation
import XCoordinator

protocol FeedPresenterDelegate: AnyObject {
    func viewDidLoad()
    func tagFilterButtonDidTap()
    func show(_ post: Post)
    func filter(by category: FeedCategory)
    func setSelectedTags(_ tags: Set<Int>)
    
    func addToFavorites(_ id: String)
    func removeFromFavotires(_ id: String)
}

protocol FeedViewDelegate: AnyObject {
    func setFavorites(_ favorites: Set<String>)
    func setPosts(_ posts: [Post])
    func setHasSelectedTags(to value: Bool)
}

final class FeedPresenter {
    // MARK: - Properties
    private let router: PostsRouter
    private let useCase: PostUseCaseProtocol
    weak var view: FeedViewDelegate?
    
    private var favotires: Set<String> = []
    private var selectedTags: Set<Int> = []
    private var postTypeIdList: [Int] = []
    private var idList: [String] = []

    // MARK: - Initializers
    init(router: PostsRouter, dependencies: UseCaseProviderProtocol) {
        self.router = router
        useCase = dependencies.postUseCase
    }
}

// MARK: - MainPresenterProtocol
extension FeedPresenter: FeedPresenterDelegate {
    func viewDidLoad() {
        favotires = useCase.getFavorites()
        view?.setFavorites(favotires)
    }
    func tagFilterButtonDidTap() {
        router.trigger(.tagCloud(self, selectedTags))
    }
    
    func show(_ post: Post) {
        switch post.type {
        case .story:
            router.trigger(.story(post.id))
        case .theory:
            router.trigger(.theory(post.id))
        case .video:
            router.trigger(.video(post.id))
        case .videoCourse:
            router.trigger(.videoCourse(post.id))
        }
    }
    
    func filter(by category: FeedCategory) {
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
        case .allCourses:
            postTypeIdList = [4]
        case .myCourses:
            postTypeIdList = [4]
            idList = Array(favotires)
        }
        
        if (category == .favorite || category == .myCourses) && favotires.isEmpty {
            self.view?.setPosts([])
        } else {
            useCase.getPosts(postTypeIdList: postTypeIdList, tagIdList: Array(selectedTags), idList: idList) { [weak self] posts in
                self?.view?.setPosts(posts)
            }
        }
    }
    
    func setSelectedTags(_ tags: Set<Int>) {
        selectedTags = tags
        
        view?.setHasSelectedTags(to: !selectedTags.isEmpty)
        
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
