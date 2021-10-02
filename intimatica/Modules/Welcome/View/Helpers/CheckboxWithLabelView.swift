//
//  TermsAndConditionsView.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/22/21.
//

import UIKit

class CheckboxWithLabelView: UIView {

    // MARK: - Properties
    private var text: String!
    private var highlightedText: String!
    private var actionHandler: (() -> Void)?
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "radio_inactive_white"), for: .normal)
        button.setImage(UIImage(named: "radio_active_yellow"), for: .selected)
        return button
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .rubik(fontSize: .small, fontWeight: .regular)
        label.numberOfLines = 2
        label.isUserInteractionEnabled = true
        return label
    }()

    // MARK: - Initializers
    init(with text: String, highlightedText: String? = nil, action: (@escaping ()->Void) = {}) {
        super.init(frame: .zero)
         
        setupView()
        setupConstraints()
        
        if let highlightedText = highlightedText {
            self.text = text
            self.highlightedText = highlightedText
            self.actionHandler = action
            setupAttibutedLabel(text: text, highlightedText: highlightedText)
        } else {
            label.text = text
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(button)
        addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.buttonTopButtom),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.buttonTopButtom),
            
            label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: Constants.labelLeading),
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupAttibutedLabel(text: String, highlightedText: String) {
        label.text = text
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: highlightedText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.appYellow, range: range)
//        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        label.attributedText = attributedString
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelDidTap(gesture:))))
    }
    
    @objc func labelDidTap(gesture: UITapGestureRecognizer) {
        let range = (text as NSString).range(of: highlightedText)
        
        if gesture.didTapAttributedTextInLabel(label: label, inRange: range) {
            actionHandler?()
        }
    }
}

extension CheckboxWithLabelView {
    private struct Constants {
        static let buttonTopButtom: CGFloat = 2
        static let labelLeading: CGFloat = 15
    }
}
