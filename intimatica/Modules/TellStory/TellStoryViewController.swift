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
    
    private lazy var agreeTitleLabel = UILabel(font: .rubik(fontSize: .small, fontWeight: .regular),
                                              textColor: .black.withAlphaComponent(0.3),
                                              text: L10n("TELL_STORY_AGREE_TITLE"))
    
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
        
        view.addSubview(titleLabel)
        view.addSubview(subTitleLable)
        view.addSubview(messageTextView)
        view.addSubview(underlineView)
        view.addSubview(agreeTitleLabel)
        view.addSubview(sendButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(Constants.leadingTrailing)
            make.trailing.equalTo(view).offset(-Constants.leadingTrailing)
            make.top.equalTo(view).offset(Constants.titleLabelTop)
        }
        
        subTitleLable.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(Constants.leadingTrailing)
            make.trailing.equalTo(view).offset(-Constants.leadingTrailing)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.subTitleLabelTop)
        }
        
        messageTextView.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(Constants.leadingTrailing)
            make.trailing.equalTo(view).offset(-Constants.leadingTrailing)
            make.top.equalTo(subTitleLable.snp.bottom).offset(Constants.messageTextViewTop)
        }
        
        underlineView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(messageTextView)
            make.top.equalTo(messageTextView.snp.bottom)
        }
        
        agreeTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(Constants.leadingTrailing)
            make.trailing.equalTo(view).offset(-Constants.leadingTrailing)
            make.top.greaterThanOrEqualTo(messageTextView.snp.bottom).offset(100)
        }
        
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(Constants.leadingTrailing)
            make.trailing.equalTo(view).offset(-Constants.leadingTrailing)
            make.top.equalTo(agreeTitleLabel.snp.bottom).offset(Constants.messageTextViewTop)
            make.bottom.equalTo(view).offset(-Constants.sendButtonBottom)
            make.height.equalTo(Constants.sendButtonHeight)
        }
    }
    
    private func setupActions() {
        sendButton.addAction { [weak self] in
            guard let self = self else { return }
            
            self.presenter.sendButtonDidTap(with: self.messageTextView.text ?? "")
        }
    }
}

// MARK: - Helper/Constants
extension TellStoryViewController {
    struct Constants {
        static let leadingTrailing: CGFloat = 50
        static let titleLabelTop: CGFloat = 140
        static let subTitleLabelTop: CGFloat = 20
        static let messageTextViewTop: CGFloat = 5
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
