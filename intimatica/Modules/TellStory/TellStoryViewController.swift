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
    
    private lazy var subTitleLable = UILabel(font: .rubik(fontSize: .small, fontWeight: .regular),
                                             textColor: .black.withAlphaComponent(0.3),
                                             text: L10n("TELL_STOTY_SUBTILE"))
    
    private lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.font = .rubik(fontSize: .regular, fontWeight: .regular)
        return textView
    }()
    
    private lazy var underlineView = SpacerView(height: 1, backgroundColor: .black.withAlphaComponent(0.3))
    
    private lazy var publishingAgreeView = PublishingAgreeView()
    
    private lazy var sendButton = UIRoundedButton(title: L10n("TELL_STOTY_BUTTON_TITLE"),
                                                    titleColor: .white,
                                                    font: .rubik(fontSize: .regular, fontWeight: .bold),
                                                    backgroundColor: .appPurple)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupActions()
        
        enableHideKeyboardOnTap()
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
        contentView.addSubview(subTitleLable)
        contentView.addSubview(messageTextView)
        contentView.addSubview(underlineView)
        contentView.addSubview(publishingAgreeView)
        contentView.addSubview(sendButton)
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
        
        subTitleLable.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.leadingTrailing)
            make.trailing.equalTo(contentView).offset(-Constants.leadingTrailing)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.subTitleLabelTop)
        }
        
        messageTextView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.leadingTrailing)
            make.trailing.equalTo(contentView).offset(-Constants.leadingTrailing)
            make.top.equalTo(subTitleLable.snp.bottom).offset(Constants.messageTextViewTop)
        }
        
        underlineView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(messageTextView)
            make.top.equalTo(messageTextView.snp.bottom)
        }
        
        publishingAgreeView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.leadingTrailing)
            make.trailing.equalTo(contentView).offset(-Constants.leadingTrailing)
            make.top.equalTo(messageTextView.snp.bottom).offset(50)
        }
        
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.leadingTrailing)
            make.trailing.equalTo(contentView).offset(-Constants.leadingTrailing)
            make.top.equalTo(publishingAgreeView.snp.bottom).offset(Constants.messageTextViewTop)
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
            
            self.showSpinner(frame: self.view.bounds, opacity: 0.3)
            self.presenter.sendButtonDidTap(with: self.messageTextView.text ?? "",
                                            isAllowedToPublish: self.publishingAgreeView.state == .active)
        }
    }
}

// MARK: - Helper/Constants
extension TellStoryViewController {
    struct Constants {
        static let leadingTrailing: CGFloat = 50
        static let titleLabelTop: CGFloat = 140
        static let subTitleLabelTop: CGFloat = 20
        static let messageTextViewTop: CGFloat = 10
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
