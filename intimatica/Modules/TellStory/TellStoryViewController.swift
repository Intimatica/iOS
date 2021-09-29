//
//  TellStoryViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/18/21.
//

import UIKit
import SnapKit

class TellStoryViewController: PopViewController {
    // MARK: - Properties
    private let presenter: TellStoryPresenterProtocol
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var titleLabel = UILabel(font: .rubik(fontSize: .title, fontWeight: .bold),
                                          text: L10n("TELL_STORY_TITLE"))
    
    private lazy var messageContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.sizeToFit()
        textView.isScrollEnabled = true
        textView.font = .rubik(fontSize: .regular, fontWeight: .regular)
        textView.delegate = self
        
        textView.text = L10n("TELL_STOTY_SUBTILE")
        textView.textColor = UIColor.lightGray
        
        return textView
    }()
        
    private lazy var publishingAgreeView = PublishingAgreeView()
    
    private lazy var sendButton = UIRoundedButton(title: L10n("TELL_STOTY_BUTTON_TITLE"),
                                                    titleColor: .white,
                                                    font: .rubik(fontSize: .regular, fontWeight: .bold),
                                                    backgroundColor: .appDarkPurple)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupActions()

        enableHideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Initializers
    init(presenter: TellStoryPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView()  {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(messageContainerView)
        contentView.addSubview(publishingAgreeView)
        contentView.addSubview(sendButton)
        
        messageContainerView.addSubview(messageTextView)
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
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.leadingTrailing)
            make.trailing.equalTo(contentView).offset(-Constants.leadingTrailing)
            make.top.equalTo(contentView).offset(Constants.titleLabelTop)
        }
        
        messageContainerView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.leadingTrailing)
            make.trailing.equalTo(contentView).offset(-Constants.leadingTrailing)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.messageContainerViewTop)
            make.height.equalTo(Constants.messageContainerViewHeight)
        }
        
        messageTextView.snp.makeConstraints { make in
            make.edges.equalTo(Constants.messageTextViewEdges)
        }
        
        publishingAgreeView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.leadingTrailing)
            make.trailing.equalTo(contentView).offset(-Constants.leadingTrailing)
            make.top.equalTo(messageContainerView.snp.bottom).offset(Constants.publishingAgreeViewTop)
        }
        
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.leadingTrailing)
            make.trailing.equalTo(contentView).offset(-Constants.leadingTrailing)
            make.top.equalTo(publishingAgreeView.snp.bottom).offset(Constants.sendButtonTop)
            make.bottom.equalTo(contentView).offset(-Constants.sendButtonBottom)
            make.height.equalTo(Constants.sendButtonHeight)
        }
    }
    
    private func setupActions() {
        publishingAgreeView.actionButton.addAction { [weak self] in
            guard let self = self else { return }
            self.publishingAgreeView.state = self.publishingAgreeView.state == .active ? .inactive : .active
        }
        
        sendButton.addAction { [weak self] in
            guard let self = self else { return }
            
            self.showActivityIndicator(with: self.view.bounds, opacity: 0.5)
            self.presenter.sendButtonDidTap(with: self.messageTextView.text ?? "",
                                            isAllowedToPublish: self.publishingAgreeView.state == .active)
        }
    }
}

// MARK: - Helper/Constants
extension TellStoryViewController {
    struct Constants {
        static let leadingTrailing: CGFloat = 50
        static let titleLabelTop: CGFloat = 120
        static let messageContainerViewHeight: CGFloat = 300
        static let messageContainerViewTop: CGFloat = 20
        static let messageTextViewEdges: CGFloat = 10
        static let publishingAgreeViewTop: CGFloat = 20
        static let sendButtonTop: CGFloat = 20
        static let sendButtonBottom: CGFloat = 150
        static let sendButtonHeight: CGFloat = 50
    }
}

// MARK: - TellStoryViewProtocol
extension TellStoryViewController: TellStoryViewProtocol {
    func dismiss() {
        dismiss(animated: true)
    }
    
    func dispay(_ error: Error) {
        showError(error.localizedDescription)
    }
}


extension TellStoryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = L10n("TELL_STOTY_SUBTILE")
            textView.textColor = UIColor.lightGray
        }
    }
}
