//
//  ProfileViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    // MARK: - Properties
    private let presenter: ProfilePresenterDelegate
    private var stories: [UserStoriesQuery.Data.Story] = []
    private let storyCellID = "StoryTableViewCellID"
//    private lazy var tableHeightConstraint = NSLayoutConstraint.init(item: tableView,
//                                                                     attribute: .height,
//                                                                     relatedBy: .equal,
//                                                                     toItem: nil,
//                                                                     attribute: .notAnAttribute,
//                                                                     multiplier: 1,
//                                                                     constant: 0)
  
    private var tableHeightConstraint: Constraint?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var profileView = ProfileView()
    
    private lazy var tableTitleLabel = UILabel(font: .rubik(fontSize: .subTitle, fontWeight: .bold),
                                               text: L10n("PROFILE_TABLE_TITLE"))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: storyCellID)
        tableView.separatorColor = .init(hex: 0xE6DAFF)
        tableView.separatorInset = .zero
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private lazy var logoutButton: UIRoundedButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("PROFILE_PAGE_LOGOUT_BUTTON_TITLE"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(.appPurple, for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .bold)
    
        return button
    }()
    
    // MARK: - Initializers
    init(presenter: ProfilePresenterDelegate) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)

        tabBarItem = UITabBarItem(title: L10n("PROFILE_TABBAR_ITEM_TITLE"),
                                  image: UIImage(named: "profile"),
                                  tag: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = L10n("PROFILE")
        navigationController?.navigationBar.isTranslucent = false
        
        setupView()
        setupConstraints()
        setupAction()
        
        presenter.viewDidLoad()
    }

    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileView)
        contentView.addSubview(tableTitleLabel)
        contentView.addSubview(tableView)
        
        profileView.fill(by: "Name", and: "email")
    }
    
    private func setupConstraints() {
//        tableHeightConstraint.isActive = true
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.leading.trailing.equalTo(view)
            make.left.right.equalTo(view)
        }
        
        profileView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(contentView)
        }
        
        tableTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.tableTitleLabelLeading)
            make.top.equalTo(profileView.snp.bottom).offset(Constants.tableTitleLabelTop)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(tableTitleLabel.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom)
            tableHeightConstraint = make.height.equalTo(0).constraint
        }
    }
    
    private func setupAction() {
        profileView.premiumButton.addAction { [weak self] in
            self?.presenter.logoutButtonDidTap()
        }
    }
}

// MARK: - Helper/Constants
extension ProfileViewController {
    struct Constants {
        static let tableTitleLabelLeading: CGFloat = 25
        static let tableTitleLabelTop: CGFloat = 30
    }
}

// MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func setStories(_ stories: [UserStoriesQuery.Data.Story]) {
        self.stories = stories
        tableView.reloadData()

        tableHeightConstraint?.layoutConstraints.first?.constant = view.frame.height * CGFloat(stories.count)
        tableView.layoutIfNeeded()
        tableHeightConstraint?.layoutConstraints.first?.constant = tableView.contentSize.height
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("show story \(stories[indexPath.row])")
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: storyCellID, for: indexPath) as? StoryTableViewCell else {
            fatalError("Failed to dequeue cell with id \(storyCellID) for indexPath \(indexPath)")
        }
        
        cell.fill(by: stories[indexPath.row])
        return cell
    }
}
