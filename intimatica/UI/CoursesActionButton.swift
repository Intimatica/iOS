//
//  AddToCoursesButton.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/9/21.
//

import UIKit

final class CoursesActionButton: UIButton {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if layer.cornerRadius != frame.height / 2 {
            layer.cornerRadius = frame.height / 2
        }
    }
    
    // MARK: - Layout
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitle(L10n("ADD_TO_MY_COURSES_BUTTON_LABEL"), for: .normal)
        setImage(UIImage(named: ""), for: .normal)
        
        setTitle(L10n(""), for: .reserved)
        setImage(UIImage(named: ""), for: .reserved)
        
        setTitleColor(.appDarkPurple, for: .normal)
        titleLabel?.font = .rubik(fontSize: .small, fontWeight: .regular)
    }
}

//fileprivate class ContainerView: UIView {
//    // MARK: - Properties
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .appPurple
//        label.font = .rubik(fontSize: .small, fontWeight: .regular)
//        return label
//    }()
//
//    private lazy var imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//
//    // MARK: - Initializers
//    init() {
//        super.init(frame: .zero)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Public
//    func setContent(title: String, imageName: String) {
//        titleLabel.text = title
//        imageView.image = UIImage(named: imageName)
//    }
//
//    // MARK: - Layout
//    private func setupView() {
//        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .white
//
//        addSubview(titleLabel)
//        addSubview(imageView)
//    }
//
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingTrailing),
//            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topBottom),
//            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.topBottom),
//
//            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
//            imageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Constants.imageViewLeading),
//            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topBottom),
//            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.leadingTrailing),
//            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.topBottom)
//        ])
//    }
//}
//
//// MARK: - Helper/Constants
//extension ContainerView {
//    struct Constants {
//        static let leadingTrailing: CGFloat = 15
//        static let topBottom: CGFloat = 7
//
//        static let imageViewLeading: CGFloat = 5
//    }
//}
