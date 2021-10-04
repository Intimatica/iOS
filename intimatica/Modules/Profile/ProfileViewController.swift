//
//  ProfileViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController, ActivityIndicatable {
    // MARK: - Properties
    private let presenter: ProfilePresenterDelegate
    lazy var activityContainerView: UIView = {
        UIView(frame: .zero)
    }()
    private var stories: [UserStoriesQuery.Data.Story] = []
    private let storyCellID = "StoryTableViewCellID"
  
    private var tableHeightConstraint: Constraint?
    
    private var navBarSpacer = SpacerView(height: 1, backgroundColor: .appLightPurple)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var profileView = ProfileView()
    
    private lazy var tellStoryView = TellStoryView(screen: .profile)
    
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
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()
    
    private lazy var logoutButton: UIRoundedButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("PROFILE_PAGE_LOGOUT_BUTTON_TITLE"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(.appDarkPurple, for: .normal)
        button.titleLabel?.font = .rubik(fontSize: .regular, fontWeight: .bold)
    
        return button
    }()
    
    // MARK: - Initializers
    init(presenter: ProfilePresenterDelegate) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)

        tabBarItem = UITabBarItem(title: L10n("PROFILE_TABBAR_ITEM_TITLE"),
                                  image: UIImage(named: "tabbar_profile_inactive"),
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .appDarkPurple
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                              NSAttributedString.Key.font: UIFont.rubik(fontSize: .regular, fontWeight: .bold)]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            setNeedsStatusBarAppearanceUpdate()
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.barTintColor = .appDarkPurple
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                                                       NSAttributedString.Key.font: UIFont.rubik(fontSize: .regular, fontWeight: .bold)]
        }
        
        navigationController?.navigationBar.isTranslucent = false
        
        presenter.viewDidLoad()
    }

    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileView)
        contentView.addSubview(tellStoryView)
        contentView.addSubview(tableTitleLabel)
        contentView.addSubview(tableView)
        contentView.addSubview(activityIndicatorView)
        
        view.addSubview(navBarSpacer)
        
        profileView.fill(by: "   ", and: "email")
    }
    
    private func setupConstraints() {
//        tableHeightConstraint.isActive = true
        
        navBarSpacer.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view)
        }
        
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
        
        tellStoryView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.tellStoryViewLeadingTrailing)
            make.top.equalTo(profileView.snp.bottom).offset(Constants.tellStoryViewTop)
        }
        
        tableTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.tableTitleLabelLeading)
            make.top.equalTo(tellStoryView.snp.bottom).offset(Constants.tableTitleLabelTop)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(tableTitleLabel.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom)
            tableHeightConstraint = make.height.equalTo(0).constraint
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(tableTitleLabel).offset(80)
        }
    }
    
    private func setupAction() {
        profileView.editProfileButton.addAction { [weak self] in
            self?.presenter.logoutButtonDidTap()
        }
        
        profileView.premiumButton.addAction { [weak self] in
            self?.presenter.applyForPremiumButtonDidTap()
        }
        
        tellStoryView.actionButton.addAction { [weak self] in
            self?.presenter.tellStoryButtonDidTap()
        }
    }
}

// MARK: - Helper/Constants
extension ProfileViewController {
    struct Constants {
        static let tellStoryViewTop: CGFloat = 20
        static let tellStoryViewLeadingTrailing: CGFloat = 15
        static let tableTitleLabelLeading: CGFloat = 15
        static let tableTitleLabelTop: CGFloat = 25
    }
}

// MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func displayError(_ message: String) {
        hideActivityIndicator()
        showError(message)
    }
    
    func setProfile(email: String, nickname: String?) {
        profileView.fill(by: nickname, and: email)
    }
    
    func setStories(_ stories: [UserStoriesQuery.Data.Story]) {
        self.stories = stories
        tableView.reloadData()

        tableTitleLabel.isHidden = stories.isEmpty
        
        tableHeightConstraint?.layoutConstraints.first?.constant = view.frame.height * CGFloat(stories.count)
        tableView.layoutIfNeeded()
        tableHeightConstraint?.layoutConstraints.first?.constant = tableView.contentSize.height
        
        activityIndicatorView.isHidden = true
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showStoryButtonDidTap(story: stories[indexPath.row])
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
