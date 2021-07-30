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
    private let storyCellIdentifier = "storyCellIdentifier"
    private let theoryCellIdentifier = "theoryCellIdentifier"
    private let videoCellIdentifier = "videoCellIdentifier"
    private let videoCourseCellIdentifier = "videoCourseCellIdentifier"
    
    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appPurple
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
//        table.allowsSelection = false
        table.backgroundView = nil
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.dataSource = self
        table.delegate = self
        table.register(StoryTableViewCell.self, forCellReuseIdentifier: storyCellIdentifier)
        table.register(TheoryTableViewCell.self, forCellReuseIdentifier: theoryCellIdentifier)
        table.register(VideoTableViewCell.self, forCellReuseIdentifier: videoCellIdentifier)
        table.register(VideoCourseTableViewCell.self, forCellReuseIdentifier: videoCourseCellIdentifier)

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
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Layout
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(topBackgroundView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topBackgroundView.heightAnchor.constraint(equalToConstant: Constants.topBackgroundViewHeight),
            topBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
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
        switch post.type {
        
        case .story:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: storyCellIdentifier, for: indexPath) as? StoryTableViewCell else {
                fatalError("Faild to dequeue cell with id \(storyCellIdentifier) for indexPath \(indexPath)")
            }
            cell.fill(by: post)
            return cell
        
        case .theory:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: theoryCellIdentifier, for: indexPath) as? TheoryTableViewCell else {
                fatalError("Faild to dequeue cell with id \(theoryCellIdentifier) for indexPath \(indexPath)")
            }
            cell.fill(by: post)
            return cell
        
        case .video:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: videoCellIdentifier, for: indexPath) as? VideoTableViewCell else {
                fatalError("Faild to dequeue cell with id \(videoCellIdentifier) for indexPath \(indexPath)")
            }
            cell.fill(by: post)
            return cell
            
        default:
            fatalError("Failed to find a reusedable cell for \(post.type)")
        }
    }
}

// MARK: - MainViewProtocol
extension PostListViewController: PostListViewProtocol {
    func setPosts(_ posts: [Post]) {
        self.posts = posts
        tableView.reloadData()
    }
}
