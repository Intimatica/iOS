//
//  NotificationViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/14/21.
//

import UIKit
import SnapKit

class NotificationViewController: UIViewController, ActivityIndicatable {
    // MARK: - Properties
    private let presenter: NotificationPresenterDelegate
    internal lazy var activityContainerView: UIView = {
        UIView(frame: view.frame)
    }()
    private var posts: [NotificationsQuery.Data.PostNotification] = []
    private var viewedPosts: Set<String> = []
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
    init(presenter: NotificationPresenterDelegate) {
        self.presenter = presenter
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar(titleColor: .black, backgroundColor: .white)
        presenter.viewWillAppear()
        showActivityIndicator(with: view.frame)
        
        NotificationCenter.default.addObserver(
              self,
              selector: #selector(applicationWillEnterForeground(_:)),
              name: UIApplication.willEnterForegroundNotification,
              object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
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
    
    @objc private func applicationWillEnterForeground(_ notification: NSNotification) {
        presenter.viewWillAppear()
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

// MARK: - NotificationViewControllerDelegate
extension NotificationViewController: NotificationViewControllerDelegate {
    func setNotificatons(_ notifications: [NotificationsQuery.Data.PostNotification]) {
        posts = notifications
        tableView.reloadData()
        hideActivityIndicator()
    }
    
    func setViewedNotifications(_ viewNotifications: Set<String>) {
        viewedPosts = viewNotifications
    }
    
    func displayError(_ message: String) {
        showError(message)
    }
    
    
}
