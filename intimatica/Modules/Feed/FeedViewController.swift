//
//  MainViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit
import SideMenu

class FeedViewController: UIViewController {
    // MARK: - Properties
    private let presenter: FeedPresenterDelegate
    private let leftSideMenu: UIViewController

    private var favorites: Set<String> = []
    private var posts: [Post] = []
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
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: nil,
                        image: UIImage(named: "burger_menu_x1.5"),
                        primaryAction: nil,
                        menu: nil)
        
        barButton.tintColor = .white
        return barButton
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        
        let viewBounds = tabBarController?.view.bounds ?? UIScreen.main.bounds
        blurEffectView.frame = viewBounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBarController?.view.addSubview(blurEffectView)
        
        return blurEffectView
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
        navigationItem.setRightBarButton(rightBarButtonItem, animated: false)
        
        title = feedSettings.tabBarTitle.lowercased().uppercaseFirstLetter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        setupActions()
        
        // QUESION: how to update cell in case of changing favorite state in post view. Delegate?
//        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.barTintColor = .appDarkPurple

        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        tabBarController?.tabBar.tintColor = .appDarkPurple
        tabBarController?.tabBar.unselectedItemTintColor = .black
        tabBarController?.tabBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        presenter.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let cell = categoryCollectionView.cellForItem(at: selectedCategoryIndexPath) as! CategoryCollectionViewCell
        cell.setState(.selected)
        
        presenter.filter(by: categoryItems[selectedCategoryIndexPath.row])
        showSpinner(frame: tableView.bounds, opacity: 0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.tableViewBottom),
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
        
        rightBarButtonItem.primaryAction = UIAction(image: rightBarButtonItem.image) { [weak self] _ in
            self?.presenter.tagFilterButtonDidTap()
       }
    }
    
    @objc func tagFilterButtonDidTap() {
        presenter.tagFilterButtonDidTap()
    }
}

// MARK: - Helper/Constraints
extension FeedViewController {
    struct Constants {
        static let rightBarButtonItemImageForActive = "tags_active_x2"
        static let rightBarButtonItemImageForInactive = "tags_inactive_x2"
        
        static let categoryFilterViewLeading: CGFloat = 15
        static let categoryFilterViewTop: CGFloat = 15
        static let categoryFilterViewHeight: CGFloat = 32
        
        static let tableViewBottom: CGFloat = 15
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
    func setFavorites(_ favorites: Set<String>) {
        self.favorites = favorites
    }
    
    func setPosts(_ posts: [Post]) {
        self.posts = posts
        tableView.reloadData()
        
        hideSpinner()
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
        showSpinner(frame: tableView.bounds, opacity: 0)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let referenceSize = (categoryItems[indexPath.row].rawValue as NSString).size(withAttributes: [.font: UIFont.rubik(fontSize: .regular, fontWeight: .medium)])
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
        showSpinner(frame: tableView.bounds, opacity: 0)
        
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
        UIView.animate(withDuration: 0.35, animations: { [weak self] in
            self?.blurEffectView.alpha = 0.8
        }, completion: { _ in
        })
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        UIView.animate(withDuration: 0.35, animations: { [weak self] in
            self?.blurEffectView.alpha = 0
        }, completion: { _ in
        })
    }
}
