//
//  AllowedPublishingView.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/23/21.
//

import UIKit
import SnapKit

final class AllowedPublishingView: UIView {
    // MARK: - Properties
    private lazy var label = UILabel(font: .rubik(fontSize: .small, fontWeight: .regular),
                                     textColor: .appDarkGray,
                                          text: L10n("STORY_AGREE_LABEL"))
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "course_selection_active")
        return imageView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(imageView)
    }
    
    private func setupConstraints(){
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.imageViewHeightWidth)
            make.leading.equalTo(self)
            make.centerY.equalTo(label.snp.centerY)
        }
        
        label.snp.makeConstraints { make in
            make.top.bottom.trailing.equalTo(self)
            make.leading.equalTo(imageView.snp.trailing).offset(Constants.labelLeading)
        }
    }
}

// MARK: - Helper/Constants
extension AllowedPublishingView {
    struct Constants {
        static let imageViewHeightWidth: CGFloat = 14
        static let labelLeading: CGFloat = 10
    }
}
