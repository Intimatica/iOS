//
//  MainViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit
import SideMenu

class FeedViewController: UIViewController, ActivityIndicatable {
    // MARK: - Properties
    private let presenter: FeedPresenterDelegate
    private let leftSideMenu: UIViewController
    
    internal lazy var activityContainerView: UIView = {
        UIView(frame: .zero)
    }()

    private var favorites: Set<String> = []
    private var posts: [Post] = []
    private(set) var notifications: [NotificationsQuery.Data.PostNotification] = []
    private var viewedNotifications: Set<String> = []
    private let postCellIdentifier = "postCellIdentifier"
    private let courseCellIdentifier = "courseCellIdentifier"

    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appDarkPurple
        return view
    }()
    
    private var categoryItems: [FeedCategory] = []
    private let collectionCellID = "collectionCellID"
    private var selectedCategoryIndexPath = IndexPath(item: 0, section: 0)
    
    private lazy var underlineView = SpacerView(height: 1, backgroundColor: .init(hex: 0x9A69FF))
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 22
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize

        return flowLayout
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceHorizontal = true
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self

        return collection
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundView = nil
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.dataSource = self
        table.delegate = self
        table.register(PostTableViewCell.self, forCellReuseIdentifier: postCellIdentifier)
        table.register(CourseTableViewCell.self, forCellReuseIdentifier: courseCellIdentifier)

        return table
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.rightBarButtonItemImageForInactive), for: .normal)
        button.addAction { [weak self] in
            self?.presenter.tagFilterButtonDidTap()
        }
        
        return UIBarButtonItem.init(customView: button)
    }()
    
    private lazy var notificationsBarButtonItem: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.bellBarButtonForInactive), for: .normal)
        button.addAction { [weak self] in
            self?.presenter.notificationsButtonDidTap()
        }
        
        return UIBarButtonItem.init(customView: button)
    }()
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: nil,
                        image: UIImage(named: "menu"),
                        primaryAction: nil,
                        menu: nil)
        
        barButton.tintColor = .white
        return barButton
    }()
    
    private lazy var blurEffectView: UIView = {
        let viewBounds = tabBarController?.view.bounds ?? UIScreen.main.bounds
        
        let view = UIView(frame: viewBounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appDarkPurple
        view.isHidden = true
        
        tabBarController?.view.addSubview(view)
        
        return view
    }()
    
    // MARK: - Initializers
    init(presenter: FeedPresenterDelegate, leftSideMenu: UIViewController, feedSettings: FeedSettings) {
        self.presenter = presenter
        self.leftSideMenu = leftSideMenu
        
        super.init(nibName: nil, bundle: nil)
        
        self.categoryItems = feedSettings.categories
        
        tabBarItem = UITabBarItem(title: feedSettings.tabBarTitle,
                                  image: UIImage(named: feedSettings.tabBarImageName),
                                  tag: 0)
        
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
        // TODO: refactor this
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 15
        navigationItem.setRightBarButtonItems([rightBarButtonItem, space, notificationsBarButtonItem], animated: false)
        
        title = feedSettings.tabBarTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = title?.lowercased().uppercaseFirstLetter()
        
        setupView()
        setupConstraints()
        setupActions()
        
        // QUESION: how to update cell in case of changing favorite state in post view. Delegate?
//        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar(titleColor: .white, backgroundColor: .appDarkPurple)
        
        self.tabBarController?.tabBar.isHidden = false
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBarController?.tabBar.standardAppearance = appearance
            tabBarController?.tabBar.scrollEdgeAppearance = appearance
        } else {
            tabBarController?.tabBar.isTranslucent = false
        }
        
        tabBarController?.tabBar.tintColor = .appDarkPurple
        tabBarController?.tabBar.unselectedItemTintColor = .black

        presenter.viewDidLoad()
        
        NotificationCenter.default.addObserver(
              self,
              selector: #selector(applicationWillEnterForeground(_:)),
              name: UIApplication.willEnterForegroundNotification,
              object: nil)
    }

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .lightContent
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let cell = categoryCollectionView.cellForItem(at: selectedCategoryIndexPath) as! CategoryCollectionViewCell
        cell.setState(.selected)
        
        showActivityIndicator(with: tableView.frame, opacity: 0.5)
        presenter.filter(by: categoryItems[selectedCategoryIndexPath.row])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Layout
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(topBackgroundView)
        view.addSubview(underlineView)
        view.addSubview(categoryCollectionView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundView.bottomAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 10),
            
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.categoryFilterViewLeading),
            categoryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.categoryFilterViewTop),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.categoryFilterViewLeading),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: Constants.categoryFilterViewHeight),
            
            underlineView.leadingAnchor.constraint(equalTo: categoryCollectionView.leadingAnchor),
            underlineView.topAnchor.constraint(equalTo: categoryCollectionView.topAnchor, constant: 0.5),
            underlineView.trailingAnchor.constraint(equalTo: categoryCollectionView.trailingAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableViewLeadingTrailing),
            tableView.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.tableViewLeadingTrailing),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupActions() {
        leftBarButtonItem.primaryAction = UIAction(image: leftBarButtonItem.image) { [weak self] _ in
            guard
                let self = self
             else {
                return
            }
            
            let menu = SideMenuNavigationController(rootViewController: self.leftSideMenu)
            menu.leftSide = true
            menu.menuWidth = self.view.frame.width - 60
            menu.presentationStyle = .viewSlideOutMenuPartialIn
            menu.delegate = self
            self.present(menu, animated: true, completion: nil)
        }
    }
    
    @objc func tagFilterButtonDidTap() {
        presenter.tagFilterButtonDidTap()
    }
    
    @objc private func applicationWillEnterForeground(_ notification: NSNotification) {
        presenter.viewDidLoad()
        presenter.filter(by: categoryItems[selectedCategoryIndexPath.row])
    }
}

// MARK: - Helper/Constraints
extension FeedViewController {
    struct Constants {
        static let rightBarButtonItemImageForActive = "tag_filter_active"
        static let rightBarButtonItemImageForInactive = "tag_filter_inactive"
        
        static let bellBarButtonForActive = "notifications_active"
        static let bellBarButtonForInactive = "notifications_inactive"
        
        static let categoryFilterViewLeading: CGFloat = 15
        static let categoryFilterViewTop: CGFloat = 15
        static let categoryFilterViewHeight: CGFloat = 32
        
        static let tableViewLeadingTrailing: CGFloat = 0
    }
}

// MARK: - UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.show(posts[indexPath.row])
    }
}

// MARK: - UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        var cell: BaseTableViewCell?
        
        switch post.type {
        
        case .story, .theory, .video:
            guard let postCell = tableView.dequeueReusableCell(withIdentifier: postCellIdentifier, for: indexPath) as? PostTableViewCell else {
                fatalError("Faild to dequeue cell with id \(postCellIdentifier) for indexPath \(indexPath)")
            }
            cell = postCell
            
        case .videoCourse:
            guard let courseCell = tableView.dequeueReusableCell(withIdentifier: courseCellIdentifier, for: indexPath) as? CourseTableViewCell else {
                fatalError("Faild to dequeue cell with id \(courseCellIdentifier) for indexPath \(indexPath)")
            }
            cell = courseCell
        }
        
        guard let cell = cell else {
            fatalError("Failed to initialize cell")
        }
        
        cell.fill(by: post, isFavorite: favorites.contains(post.id), indexPath: indexPath, delegate: self)
        return cell
    }
}

// MARK: - BaseTableViewCellDelegate
extension FeedViewController: BaseTableViewCellDelegate {
    func addToFavorites(by indexPath: IndexPath) {
        presenter.addToFavorites(posts[indexPath.row].id)
    }
    
    func removeFromFavorites(by indexPath: IndexPath) {
        presenter.removeFromFavotires(posts[indexPath.row].id)
        
        let category = categoryItems[selectedCategoryIndexPath.row]
        if category == .favorite || category == .myCourses {
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}

// MARK: - MainViewProtocol
extension FeedViewController: FeedViewDelegate {
    func setViewedNotifications(_ viewedNotifications: Set<String>) {
        self.viewedNotifications = viewedNotifications
        
        guard let button = notificationsBarButtonItem.customView as? UIButton else { return }
        button.setImage(UIImage(named: Constants.bellBarButtonForInactive), for: .normal)
    }
    
    func getNotifications() -> [NotificationsQuery.Data.PostNotification] {
        notifications
    }
    
    func setNotifications(_ notifications: [NotificationsQuery.Data.PostNotification]) {
        self.notifications = notifications
        
        // set active bell if we have not viewed posts
        for post in notifications {
            if !viewedNotifications.contains(post.id) {
                guard let button = notificationsBarButtonItem.customView as? UIButton else { return }
                button.setImage(UIImage(named: Constants.bellBarButtonForActive), for: .normal)
                
                break;
            }
        }
    }
    
    func setFavorites(_ favorites: Set<String>) {
        self.favorites = favorites
    }
    
    func setPosts(_ posts: [Post]) {
        self.posts = posts
        tableView.reloadData()
        
        hideActivityIndicator()
    }
    
    func setHasSelectedTags(to has: Bool) {
        guard let button = rightBarButtonItem.customView as? UIButton else { return }
        
        if has {
            button.setImage(UIImage(named: Constants.rightBarButtonItemImageForActive), for: .normal)
        } else {
            button.setImage(UIImage(named: Constants.rightBarButtonItemImageForInactive), for: .normal)
        }
        
        // TODO refactor this
        posts = []
        tableView.reloadData()
        showActivityIndicator(with: tableView.frame, opacity: 0.5)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let referenceSize = (categoryItems[indexPath.row].rawValue as NSString).size(withAttributes: [.font: UIFont.rubik(fontSize: .subRegular, fontWeight: .medium)])
        return .init(width: referenceSize.width + 2, height: referenceSize.height + CategoryCollectionViewCell.Constants.nameLabelTop)
    }
}

// MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedCategoryIndexPath != indexPath else {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        cell.setState(.selected)
        
        let category = categoryItems[indexPath.row]
        
        presenter.filter(by: category)
        
        posts = []
        tableView.reloadData()
        showActivityIndicator(with: tableView.frame, opacity: 0.5)
        
        if let selectedCell = collectionView.cellForItem(at: selectedCategoryIndexPath) as? CategoryCollectionViewCell {
            selectedCell.setState(.normal)
        }
        
        
        selectedCategoryIndexPath = indexPath
        
        collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension FeedViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as? CategoryCollectionViewCell
        else {
            fatalError("Failed to dequeue collection cell with id \(collectionCellID) for indexPath \(indexPath)")
        }
        
        cell.fill(by: categoryItems[indexPath.row].rawValue)
        return cell
    }
}

// MARK: - SideMenuNavigationControllerDelegate
extension FeedViewController: SideMenuNavigationControllerDelegate, UINavigationControllerDelegate {

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        blurEffectView.isHidden = false
        
        UIView.animate(withDuration: 0.35, animations: { [weak self] in
            self?.blurEffectView.alpha = 0.7
        }, completion: { _ in
        })
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        UIView.animate(withDuration: 0.35, animations: { [weak self] in
            self?.blurEffectView.alpha = 0
        }, completion: { [weak self] _ in
            self?.blurEffectView.isHidden = true
        })
    }
}
