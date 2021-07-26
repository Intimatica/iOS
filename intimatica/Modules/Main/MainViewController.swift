//
//  MainViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    private let posts = [
        Post(id: 1, title: "Правда и мифы про предохранение.", imageName: "post_image_1", tags: ["Здоровье", "половое созревание"]),
        Post(id: 2, title: "У меня выявили ВПЧ", imageName: "post_image_2", tags: ["Здоровье", "половое созревание"]),
    ]
    
    let cellIdentifier = "cellIdentifier"
    
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
        table.allowsSelection = false
        table.backgroundView = nil
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.dataSource = self
        table.delegate = self
        table.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
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
extension MainViewController {
    struct Constants {
        static let topBackgroundViewHeight: CGFloat = 228
        
        static let tableViewTop: CGFloat = 174
        static let tableViewLeadingTrailing: CGFloat = 25
        static let tableViewCellSpacing: CGFloat = 25
    }
}


// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewCell else {
            fatalError("Faild to dequeue cell with id \(cellIdentifier)")
        }
        
        cell.fill(by: posts[indexPath.row])
        
        return cell
    }
}
