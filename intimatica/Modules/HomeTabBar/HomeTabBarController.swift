//
//  HomeTabBarController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

class HomeTabBarController: UITabBarController {
    // MARK: - Properties
    private var router: Router!
    private var useCaseProvider: UseCaseProviderProtocol!
    
    lazy var postListTabBar: PostListViewController = {
        let presenter = PostListPresenter(router: router, dependencies: useCaseProvider)
        let postListTabBar = PostListViewController(presenter: presenter)
        presenter.view = postListTabBar
        
        postListTabBar.tabBarItem = UITabBarItem(title: L10n("MAIN_TABBAR_ITEM_TITLE"),
                                             image: UIImage(named: "main"), tag: 0)

        return postListTabBar
    }()

    lazy var courcesTabBar: CourcesViewController = {
        let courcesTabBar = CourcesViewController()
        courcesTabBar.tabBarItem = UITabBarItem(title: L10n("COURCES_TABBAR_ITEM_TITLE"),
                                                image: UIImage(named: "cources"), tag: 0)

        return courcesTabBar
    }()

    lazy var profileTabBar: CourcesViewController = {
        let profileTabBar = CourcesViewController()
        profileTabBar.tabBarItem = UITabBarItem(title: L10n("PROFILE_TABBAR_ITEM_TITLE"),
                                                image: UIImage(named: "profile"), tag: 0)

        return profileTabBar
    }()

    // MARK: - Initializers
    init(router: Router, dependencies: UseCaseProviderProtocol) {
        self.router = router
        self.useCaseProvider = dependencies
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Layout
    func setupUI() {
        viewControllers = [postListTabBar, courcesTabBar, profileTabBar]

        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .appPurple
    }
}
