//
//  TagCloudViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/12/21.
//

import UIKit
import SnapKit
import AlignedCollectionViewFlowLayout

// TODO: fix scroll view

final class TagCloudViewController: PopViewController {
    // MARK: - Properties
    private var tagList: [TagsQuery.Data.Tag] = []
    private var selectedTags: Set<Int> = []
    
    private let tagCellId = "TagCollectionViewCellID"
    private let presenter: TagCloudPresenterDelegate
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .center)
    
    private lazy var collectionView: UICollectionView = {
        alignedFlowLayout.estimatedItemSize = .init(width: 100, height: 30)
        alignedFlowLayout.minimumLineSpacing = 18
        alignedFlowLayout.minimumInteritemSpacing = 11
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: alignedFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: tagCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
        
    private lazy var actionButton = UIRoundedButton(title: L10n("TAG_CLOUD_SHOW_BUTTON_TITLE"),
                                                    titleColor: .white,
                                                    font: .rubik(fontSize: .subRegular, fontWeight: .bold),
                                                    backgroundColor: .appDarkPurple)

    private lazy var clearButton: UIButton = {
       let button = UIRoundedButton(title: L10n("TAG_CLOUD_CLEAR_BUTTON_TITLE"),
                                    titleColor: .appDarkPurple,
                                    font: .rubik(fontSize: .subRegular, fontWeight: .bold),
                                    backgroundColor: .clear)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.appDarkPurple.cgColor
        return button
    }()
    
    // MARK: - Initializers
    init(presenter: TagCloudPresenterDelegate) {
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
        setupAction()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showActivityIndicator()
    }
    
    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(collectionView)
        contentView.addSubview(actionButton)
        contentView.addSubview(clearButton)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(closeButton.snp.bottom)
        }

        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.bottom.equalTo(scrollView)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(Constants.collectionViewLeadingTrailing)
            make.top.equalTo(closeButton.snp.bottom).offset(Constants.collectionViewTop)
        }
        
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(collectionView)
            make.top.equalTo(collectionView.snp.bottom).offset(Constants.actionButtonTop)
            make.height.equalTo(Constants.actionButtonHeight)
        }
        
        clearButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(collectionView)
            make.top.equalTo(actionButton.snp.bottom).offset(Constants.clearButtonTop)
            make.height.equalTo(Constants.actionButtonHeight)
            make.bottom.equalTo(contentView.snp.bottom).offset(-Constants.collectionViewTop)
        }

        let constraint = collectionView.heightAnchor.constraint(equalToConstant: Constants.collectionViewHeight)
        constraint.priority = .defaultLow
        constraint.isActive = true
    }
    
    private func setupAction() {
        actionButton.addAction { [weak self] in
            guard let self = self else { return }
            self.presenter.showButtonDidTap(selectedTags: self.selectedTags)
        }
        
        clearButton.addAction { [weak self] in
            guard
                let self = self,
                let cells = self.collectionView.visibleCells as? [TagCollectionViewCell]
            else { return }
            self.selectedTags = []
            
            for cell in cells {
                cell.state = .inactive
            }
            
            self.presenter.clearButtonDidTap()
        }
    }
}

// MARK: - Helper/Constants
extension TagCloudViewController {
    struct Constants {
        static let collectionViewLeadingTrailing: CGFloat = 45
        static let collectionViewHeight: CGFloat = 400
        static let collectionViewTop: CGFloat = 120
        
        static let actionButtonTop: CGFloat = 50
        static let actionButtonHeight: CGFloat = 50
        
        static let clearButtonTop: CGFloat = 20
    }
}

// MARK: - TagCloudViewProtocol
extension TagCloudViewController: TagCloudViewDelegate {
    func display(_ tags: [TagsQuery.Data.Tag], with selectedTags: Set<Int>) {
        tagList = tags
        self.selectedTags = selectedTags
        collectionView.reloadData()
        
        collectionView.layoutIfNeeded()
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
        view.layoutIfNeeded()
        view.layoutSubviews()
        
        hideActivityIndicator()
    }
    
    func displayError(_ text: String) {
        showError(text)
    }
}

// MARK: - UICollectionViewDelegate
extension TagCloudViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TagCollectionViewCell
        cell.toggleState()
        
        guard let id = Int(tagList[indexPath.row].id) else { return }
        
        if cell.state == .active {
            selectedTags.insert(id)
        } else {
            selectedTags.remove(id)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension TagCloudViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagCellId, for: indexPath) as? TagCollectionViewCell,
              let tagName = tagList[indexPath.row].name,
              let tagId = Int(tagList[indexPath.row].id)
        else {
            fatalError("Failed to dequeue cell with ID \(tagCellId) for IndexPath \(indexPath)")
        }
                
        cell.fill(by: tagName)
        
        if selectedTags.contains(tagId) {
            cell.state = .active
        }
        
        return cell
    }
}
