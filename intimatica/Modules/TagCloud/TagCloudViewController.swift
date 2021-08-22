//
//  TagCloudViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/12/21.
//

import UIKit
import AlignedCollectionViewFlowLayout

final class TagCloudViewController: UIViewController {
    // MARK: - Properties
    private var tagList: [TagsQuery.Data.Tag] = []
    private var selectedTags: Set<Int> = []
    
    private let tagCellId = "TagCollectionViewCellID"
    private var presenter: TagCloudPresenterDelegate!
    private lazy var closeButton = CloseButton()
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
                                                    font: .rubik(fontSize: .regular, fontWeight: .bold),
                                                    backgroundColor: .appPurple)

    private lazy var clearButton = UIRoundedButton(title: L10n("TAG_CLOUD_CLEAR_BUTTON_TITLE"),
                                                    titleColor: .white,
                                                    font: .rubik(fontSize: .regular, fontWeight: .bold),
                                                    backgroundColor: .appPurple)
    
    // MARK: - Initializers
    init(presenter: TagCloudPresenterDelegate) {
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
        setupAction()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showSpinner()
    }
    
    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(collectionView)
        view.addSubview(actionButton)
        view.addSubview(clearButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: Constants.closeButtonWidth),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.closeButtonTopTrailing),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.closeButtonTopTrailing),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.collectionViewLeadingTrailing),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.collectionViewTop),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.collectionViewLeadingTrailing),
            
            actionButton.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            actionButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Constants.actionButtonTop),
            actionButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight),
            
            clearButton.leadingAnchor.constraint(equalTo: actionButton.leadingAnchor),
            clearButton.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: Constants.clearButtonTop),
            clearButton.trailingAnchor.constraint(equalTo: actionButton.trailingAnchor),
            clearButton.heightAnchor.constraint(equalTo: actionButton.heightAnchor)
        ])
        
        let constraint = collectionView.heightAnchor.constraint(equalToConstant: Constants.collectionViewHeight)
        constraint.priority = .defaultLow
        constraint.isActive = true
    }
    
    private func setupAction() {
        closeButton.addAction { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
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
        }
    }
}

// MARK: - Helper/Constants
extension TagCloudViewController {
    struct Constants {
        static let closeButtonWidth: CGFloat = 40
        static let closeButtonTopTrailing: CGFloat = 15
        static let collectionViewLeadingTrailing: CGFloat = 45
        static let collectionViewHeight: CGFloat = 400
        static let collectionViewTop: CGFloat = 165
        
        static let actionButtonTop: CGFloat = 50
        static let actionButtonHeight: CGFloat = 50
        
        static let clearButtonTop: CGFloat = 30
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
        
        hideSpinner()
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
