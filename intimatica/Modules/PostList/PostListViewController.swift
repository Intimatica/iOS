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
    private var posts: [Post] = []
    private let postCellIdentifier = "postCellIdentifier"
    private let courseCellIdentifier = "courseCellIdentifier"
    
    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appPurple
        return view
    }()
    
    private let tagItems: [Int] = []
    private let categoryFilterItems: [String] = FeedCategoryFilter.toArray()

    private let verticalInset: CGFloat = 0
    private let horizontalInset: CGFloat = 0
    private let collectionCellID = "collectionCellID"
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
//        flowLayout.itemSize = CGSize(width: 50, height: 20)

        // QUESTION: why line spacing works as interitem spacing
        flowLayout.minimumLineSpacing = 22
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.sectionInset = UIEdgeInsets (top: verticalInset,
                                                left: horizontalInset,
                                                bottom: verticalInset,
                                                right: horizontalInset)
        return flowLayout
    }()
    
    private lazy var categoryFilterView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(CategoryFilterCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceHorizontal = true
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        
        collection.layer.borderWidth = 1
        collection.layer.borderColor = UIColor.green.cgColor
        
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
    
    // MARK: - Initializers
    init(presenter: PostListPresenterProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
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
}

// MARK: - Helper/Constraints
extension PostListViewController {
    struct Constants {
        static let topBackgroundViewHeight: CGFloat = 228
                
        static let categoryFilterViewLeading: CGFloat = 15
        static let categoryFilterViewTop: CGFloat = 110
        static let categoryFilterViewHeight: CGFloat = 50
        
        static let tableViewTop: CGFloat = 174
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
        
        cell.fill(by: post)
        return cell
    }
}

// MARK: - MainViewProtocol
extension PostListViewController: PostListViewProtocol {
    func setPosts(_ posts: [Post]) {
        self.posts = posts
        tableView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PostListViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let inset: CGFloat = 0
//        let minimumInteritemSpacing: CGFloat = 22
//        let cellsPerRow = categoryFilterItems.count
//
//        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
//        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
//        return CGSize(width: itemWidth, height: itemWidth)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        .zero
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        0
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        22
//    }
}

// MARK: - UICollectionViewDelegate
extension PostListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryFilterCollectionViewCell
        cell.didSelect()
        
        let category = FeedCategoryFilter.init(rawValue: categoryFilterItems[indexPath.row]) ?? .all
        
        presenter.filter(by: category, and: tagItems)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryFilterCollectionViewCell
        cell.didDeselect()
    }
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
