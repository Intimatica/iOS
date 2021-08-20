//
//  MainViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

class PostListViewController: UIViewController {
    // MARK: - Properties
    private var presenter: PostListPresenterProtocol!
    private var favorites: Set<String> = []
    private var posts: [Post] = []
    private let postCellIdentifier = "postCellIdentifier"
    private let courseCellIdentifier = "courseCellIdentifier"
    
    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appPurple
        return view
    }()
    
    private let categoryFilterItems: [String] = FeedCategoryFilter.toArray()

    private let verticalInset: CGFloat = 0
    private let horizontalInset: CGFloat = 0
    private let collectionCellID = "collectionCellID"
    private var selectedCategoryIndexPath = IndexPath(item: 0, section: 0)
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 22
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
//        flowLayout.sectionInset = UIEdgeInsets (top: verticalInset,
//                                                left: horizontalInset,
//                                                bottom: verticalInset,
//                                                right: horizontalInset)
        return flowLayout
    }()
    
    private lazy var categoryFilterView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(CategoryFilterCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceHorizontal = true
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        
//        collection.layer.borderWidth = 1
//        collection.layer.borderColor = UIColor.green.cgColor
        
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
        let barButtonItem = UIBarButtonItem(title: nil,
                               image: UIImage(named: "tags_inactive_x2"),
                               primaryAction: nil,
                               menu: nil)
        barButtonItem.tintColor = .white
        return barButtonItem
    }()
    
    // MARK: - Initializers
    init(presenter: PostListPresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        
        // TODO refactor
        // COURSES_TABBAR_ITEM_TITLE
        tabBarItem = UITabBarItem(title: L10n("POST_LIST_TABBAR_ITEM_TITLE"),
                                  image: UIImage(named: "main"),
                                  tag: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButtonItem
        
        setupView()
        setupConstraints()
        setupActions()
        
//        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = .appPurple
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // QUESION: how to update cell in case of changing favorite state in post view
        presenter.viewDidLoad()
        
        let cell = categoryFilterView.cellForItem(at: selectedCategoryIndexPath) as! CategoryFilterCollectionViewCell
        cell.setState(.selected)
    }
    
    // MARK: - Layout
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(topBackgroundView)
        view.addSubview(categoryFilterView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topBackgroundView.heightAnchor.constraint(equalToConstant: Constants.topBackgroundViewHeight),
            topBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            categoryFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.categoryFilterViewLeading),
            categoryFilterView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.categoryFilterViewTop),
            categoryFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryFilterView.heightAnchor.constraint(equalToConstant: Constants.categoryFilterViewHeight),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableViewLeadingTrailing),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.tableViewTop),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.tableViewLeadingTrailing),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupActions() {
        rightBarButtonItem.primaryAction = UIAction(image: rightBarButtonItem.image) { [weak self] _ in
            self?.presenter.tagFilterButtonDidTap()
       }
    }
    
    @objc func tagFilterButtonDidTap() {
        presenter.tagFilterButtonDidTap()
    }
}

// MARK: - Helper/Constraints
extension PostListViewController {
    struct Constants {
        static let topBackgroundViewHeight: CGFloat = 150
        
        static let categoryFilterViewLeading: CGFloat = 15
        static let categoryFilterViewTop: CGFloat = 30
        static let categoryFilterViewHeight: CGFloat = 50
        
        static let tableViewTop: CGFloat = 100
        static let tableViewLeadingTrailing: CGFloat = 0
        static let tableViewCellSpacing: CGFloat = 25
    }
}

// MARK: - UITableViewDelegate
extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.show(posts[indexPath.row])
    }
}

// MARK: - UITableViewDataSource
extension PostListViewController: UITableViewDataSource {
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
extension PostListViewController: BaseTableViewCellDelegate {
    func addToFavorites(by indexPath: IndexPath) {
        presenter.addToFavorites(posts[indexPath.row].id)
    }
    
    func removeFromFavorites(by indexPath: IndexPath) {
        presenter.removeFromFavotires(posts[indexPath.row].id)
        
        if categoryFilterItems[selectedCategoryIndexPath.row] == FeedCategoryFilter.toArray().last ?? "" {
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}

// MARK: - MainViewProtocol
extension PostListViewController: PostListViewProtocol {
    func setFavorites(_ favorites: Set<String>) {
        self.favorites = favorites
    }
    
    func setPosts(_ posts: [Post]) {
        self.posts = posts
        tableView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PostListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let referenceSize = (categoryFilterItems[indexPath.row] as NSString).size(withAttributes: [.font: UIFont.rubik(fontSize: .regular, fontWeight: .medium)])
        return .init(width: referenceSize.width + 2, height: referenceSize.height + CategoryFilterCollectionViewCell.Constants.nameLabelTop)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        .zero
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        20
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        0
//    }
}

// MARK: - UICollectionViewDelegate
extension PostListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedCategoryIndexPath != indexPath else {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryFilterCollectionViewCell
        cell.setState(.selected)
        
        let category = FeedCategoryFilter.init(rawValue: categoryFilterItems[indexPath.row]) ?? .all
        
        presenter.filter(by: category)
        
        let selectedCell = collectionView.cellForItem(at: selectedCategoryIndexPath) as! CategoryFilterCollectionViewCell
        selectedCell.setState(.normal)
        
        selectedCategoryIndexPath = indexPath
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! CategoryFilterCollectionViewCell
//        cell.setState(.normal)
//    }
}

// MARK: - UICollectionViewDataSource
extension PostListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryFilterItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as? CategoryFilterCollectionViewCell
        else {
            fatalError("Failed to dequeue collection cell with id \(collectionCellID) for indexPath \(indexPath)")
        }
        
        cell.fill(by: categoryFilterItems[indexPath.row])
        return cell
    }
}
