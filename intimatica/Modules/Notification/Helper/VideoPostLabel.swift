//
//  VideoPostLabel.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/15/21.
//

import UIKit
import SnapKit

final class VideoPostLabel: UIView {
    // MARK: - Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "video_course_post_label_icon")
        return imageView
    }()
    
    private lazy var textLabel = UILabel(font: .rubik(fontSize: .small, fontWeight: .medium),
                                         textColor: .white,
                                         text: L10n("TABLE_CELL_POST_LABEL_VIDEO"))
    
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if layer.cornerRadius != bounds.height / 2 {
            layer.cornerRadius = bounds.height / 2
        }
    }
    
    // MARK: - Layout
    
    private func setupView() {
        backgroundColor = .init(hex: 0x4BD4FF)
        layer.masksToBounds = true
        
        addSubview(imageView)
        addSubview(textLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.imageViewWidthHeight)
            make.leading.equalTo(self).offset(Constants.imageViewLeading)
            make.top.bottom.equalTo(self).inset(Constants.imageViewTopBottom)
        }
        
        textLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(Constants.textLabelLeading)
            make.trailing.equalTo(self).inset(Constants.textLabelTrailing)
        }
    }
}

// MARK: - Helper/Constants
extension VideoPostLabel {
    struct Constants {
        static let imageViewWidthHeight: CGFloat = 11
        static let imageViewLeading: CGFloat = 10
        static let imageViewTopBottom: CGFloat = 5
        static let textLabelLeading: CGFloat = 3
        static let textLabelTrailing: CGFloat = 10
    }
}
