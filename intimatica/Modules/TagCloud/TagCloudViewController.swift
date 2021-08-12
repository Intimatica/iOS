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
    private var presenter: TagCloudPresenterProtocol!
    private lazy var closeButton = CloseButton()
    private lazy var alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .justified, verticalAlignment: .center)
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: alignedFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    // MARK: - Initializers
    init(presenter: TagCloudPresenterProtocol) {
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
    
    // MARK: - Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: Constants.closeButtonWidth),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.closeButtonTopTrailing),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.closeButtonTopTrailing),
        ])
    }
    
    private func setupAction() {
        closeButton.addAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Helper/Constants
extension TagCloudViewController {
    struct Constants {
        static let closeButtonWidth: CGFloat = 40
        static let closeButtonTopTrailing: CGFloat = 15
    }
}

// MARK: - TagCloudViewProtocol
extension TagCloudViewController: TagCloudViewProtocol {
    func display(_ tags: [TagsQuery.Data.Tag]) {
        
    }
}
