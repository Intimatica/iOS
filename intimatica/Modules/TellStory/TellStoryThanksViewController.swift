//
//  TellStoryThanksViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/19/21.
//

import UIKit
import SnapKit

class TellStoryThanksViewController: PopViewController {
    // MARK: - Properties
    private lazy var titleLabel = UILabel(font: .rubik(fontSize: .title, fontWeight: .bold),
                                          textColor: .black,
                                          text: L10n("TELL_STORY_THANKS_TITLE"))
    private lazy var subTitle: UILabel = {
        let label = UILabel(font: .rubik(fontSize: .regular, fontWeight: .regular),
                                                 textColor: .black,
                                                 text: L10n("TELL_STORY_THANKS_SUBTITLE"))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView = UIImageView(name: "story_post_thanks_picture",
                                             contentMode: .scaleAspectFit)
    private lazy var actionButton = UIRoundedButton(title: L10n("TELL_STORY_THANKS_BUTTON_TITLE"),
                                                    titleColor: .white,
                                                    font: .rubik(fontSize: .regular, fontWeight: .bold),
                                                    backgroundColor: .appPurple)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupActions()
    }

    // MARK: - Layout
    private func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(subTitle)
        view.addSubview(imageView)
        view.addSubview(actionButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(Constants.titleLabelTop)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.subTitleLabelTop)
            make.leading.equalTo(view).offset(Constants.subTitleLeadingTrailing)
            make.trailing.equalTo(view).offset(-Constants.subTitleLeadingTrailing)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(Constants.imageViewTop)
            make.height.equalTo(Constants.imageViewHeight)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constants.actionButtonTop)
            make.leading.trailing.equalTo(subTitle)
            make.height.equalTo(Constants.actionButtonHeight)
        }
    }
    
    private func setupActions() {
        actionButton.addAction { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - Helper/Constants
extension TellStoryThanksViewController {
    struct Constants {
        static let titleLabelTop: CGFloat = 90
        static let subTitleLabelTop: CGFloat = 15
        static let subTitleLeadingTrailing: CGFloat = 25
        static let imageViewHeight: CGFloat = 230
        static let imageViewTop: CGFloat = 20
        static let actionButtonTop: CGFloat = 40
        static let actionButtonHeight: CGFloat = 50
    }
}
