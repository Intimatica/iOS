//
//  HomeTabBarController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

class HomeTabBarController: UITabBarController {
    // MARK: - Properties
    lazy var mainTabBar: MainViewController = {
        let mainTabBar = MainViewController()
        mainTabBar.tabBarItem = UITabBarItem(title: L10n("MAIN_TABBAR_ITEM_TITLE"),
                                             image: UIImage(named: "main"), tag: 0)
        
        return mainTabBar
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
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Layout
    func setupUI() {
        viewControllers = [mainTabBar, courcesTabBar, profileTabBar]
        
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .appPurple
    }
}
