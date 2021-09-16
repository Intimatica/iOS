//
//  NotificationViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/14/21.
//

import UIKit
import SnapKit

class NotificationViewController: UIViewController {
    // MARK: - Properties
    private let presenter: NotificationPresenterDelegate
    private let posts: [NotificationsQuery.Data.PostNotification]
    var viewedPosts: Set<String>
    private let cellID = "NotificationCellID"
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.dataSource = self
        table.delegate = self
        table.register(NotificationTableViewCell.self, forCellReuseIdentifier: cellID)
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    private lazy var backBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "    "
        barButton.tintColor = .appDarkPurple
        return barButton
    }()
    
    // MARK: - Initializers
    init(presenter: NotificationPresenterDelegate, posts: [NotificationsQuery.Data.PostNotification], viewedPosts: Set<String>) {
        self.presenter = presenter
        self.posts = posts
        self.viewedPosts = viewedPosts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = backBarButtonItem
        
        setupView()
        setupConstraints()
        
        tableView.reloadData()
//        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK: - Layout
    private func setupView() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(view)
        }
    }
}


// MARK: - UITableViewDelegate
extension NotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.show(posts[indexPath.row])
    }
}

// MARK: - UITableViewDataSource
extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? NotificationTableViewCell else {
            fatalError("Failed to dequeue cell \(cellID) for indexPath: \(indexPath)")
        }
        
        let post = posts[indexPath.row]
        cell.fill(by: post, isViewed: viewedPosts.contains(post.id))
        viewedPosts.insert(post.id)
        presenter.markAsViewed(post.id)
        
        return cell
    }
}
