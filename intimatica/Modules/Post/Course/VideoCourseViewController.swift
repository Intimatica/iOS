//
//  VideoCourseViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/5/21.
//

import UIKit

class VideoCourseViewController: BasePostViewController {
    typealias Video = VideoCoursePostQuery.Data.Post.PostType.AsComponentPostTypeVideoCourse.Video
    
    // MARK: - Properties
    private var videoList: [Video] = []
    
    private lazy var courseTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .subTitle, fontWeight: .medium)
        label.textColor = .black
        label.text = L10n("COURSE_POST_TITLE")
        return label
    }()
    
    private lazy var videoTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubik(fontSize: .subTitle, fontWeight: .medium)
        label.textColor = .black
        label.text = L10n("COURSE_VIDEO_TITLE")
        return label
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.register(TableViewCell.self, forCellReuseIdentifier: "cellId")
        
        return table
    }()
    
    // MARK: - Initializers
    init(presenter: VideoCoursePresenterProtocol) {
        super.init(navigationBarType: .addFavorite)
        
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
    
    // MARK: - Layout
    private func setupView() {
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(headerStack)
        scrollView.addSubview(markdownView)
        scrollView.addSubview(spacerView)
        scrollView.addSubview(videoTitle)
        scrollView.addSubview(table)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(tagsStack)
        headerStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .clear))
        headerStack.addArrangedSubview(authorView)
        headerStack.addArrangedSubview(SpacerView(height: 1, backgroundColor: .appPurple))
        headerStack.addArrangedSubview(courseTitle)
    }
    
    private func setupConstraints() {
        let contentLayoutGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            headerImageView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            headerImageView.widthAnchor.constraint(equalTo: view.widthAnchor),

            headerStack.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: Constants.headerStackLeadingTrailing),
            headerStack.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: Constants.headerStackTop),
            headerStack.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: -Constants.headerStackLeadingTrailing),
                        
            markdownView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            markdownView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: Constants.markdownViewTop),
            markdownView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            
            spacerView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            spacerView.topAnchor.constraint(equalTo: markdownView.bottomAnchor, constant: Constants.spacerViewTop),
            spacerView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            
            videoTitle.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            videoTitle.topAnchor.constraint(equalTo: spacerView.bottomAnchor),
            videoTitle.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor),
//            videoTitle.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
            
            table.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor),
            table.topAnchor.constraint(equalTo: videoTitle.bottomAnchor, constant: 20),
            table.widthAnchor.constraint(equalTo: headerStack.widthAnchor),
            table.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant:  -50),
//            table.heightAnchor.constraint(greaterThanOrEqualToConstant: 500)
        ])
    }
}

// MARK: - VideoCourseViewProtocol
extension VideoCourseViewController: VideoCourseViewProtocol {
    func display(_ post: VideoCoursePostQuery.Data.Post) {
        guard
            let imageUrl = post.image?.url,
            let tags = post.tags?.compactMap({ $0?.name }),
            let authorName = post.author?.name,
            let authorJobTitle = post.author?.jobTitle,
            let authorPhotoUrl = post.author?.photo?.url,
            let content = post.postType.first??.asComponentPostTypeVideoCourse?.description,
            let videoList = post.postType.first??.asComponentPostTypeVideoCourse?.video?.compactMap({ $0 })
        else {
            return
        }
        
        headerImageView.kf.indicatorType = .activity
        headerImageView.kf.setImage(with: URL(string: AppConstants.serverURL + imageUrl))
        
        titleLabel.text = post.title
        
        tags.forEach { tagName in
            tagsStack.addArrangedSubview(createTagView(with: tagName))
        }
        tagsStack.addArrangedSubview(UIView())
        
        authorView.imageView.kf.indicatorType = .activity
        authorView.imageView.kf.setImage(with: URL(string: AppConstants.serverURL + authorPhotoUrl))
        authorView.label.setAttributedText(withString: L10n("AUTHOR") + "\n" + authorName + "\n" + authorJobTitle,
                                           boldString: authorName,
                                           font: authorView.label.font)
        
        markdownView.load(markdown: fixContentStrapiLinks(content), enableImage: true)
//        markdownView.load(markdown: "", enableImage: true)
        
        self.videoList = videoList
        table.reloadData()
        table.heightAnchor.constraint(equalToConstant: table.contentSize.height * 10).isActive = true

        markdownView.onRendered = { [weak self] height in
            self?.hideSpinner()
            self?.markdownView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// MARK: - UITableViewDataSource
extension VideoCourseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? TableViewCell else {
            fatalError("Failed to dequeue table cell for indexPath \(indexPath)")
        }
        
        cell.fill(by: videoList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension VideoCourseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = table.cellForRow(at: indexPath) as? TableViewCell else {
            return
        }

        cell.videoPlayerView.playVideo()
    }
}
