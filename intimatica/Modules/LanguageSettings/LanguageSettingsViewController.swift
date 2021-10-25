//
//  LanguageSelectViewController.swift
//  intimatica
//
//  Created by RustFox on 10/25/21.
//

import UIKit
import SnapKit

class LanguageSettingsViewController: UIViewController {
    //MARK: - Properties
    private let presenter: LanguageSettingsPresenter
    private var currentLanguage = ""
    private var languages: [(code: String, name: String)] = []
    
    private let tableCellID = "tableCellID";
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundView = nil
        table.backgroundColor = .clear
        
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: tableCellID)
        return table
    }()
    
    // MARK: - Initializers
    init(presenter: LanguageSettingsPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()

        navigationItem.leftBarButtonItem = Button.backBarButtonItem()
        title = L10n("PROFILE_CHANGE_LANGUAGE")
        
        presenter.viewDidLoad()
    }
    
    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

// MARK: - LanguageSettingsViewControllerDelegate
extension LanguageSettingsViewController: LanguageSettingsViewControllerDelegate {
    func setLanguages(_ languages: [(code: String, name: String)]) {
        self.languages = languages
        tableView.reloadData()
    }
    
    func setCurrentLanguage(_ lang: String) {
        currentLanguage = lang
    }
}

// MARK: - UITableViewDelegate
extension LanguageSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        presenter.updateCurrentLanguage(to: languages[indexPath.row].code)
        showError(L10n("LANGUAGE_SETTINGS_NOTIFICATION"), title: "")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

// MARK: - UITableViewDataSource
extension LanguageSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID) else {
            fatalError("Failed to dequeue table cell")
        }
        
        cell.textLabel?.text = languages[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
}
