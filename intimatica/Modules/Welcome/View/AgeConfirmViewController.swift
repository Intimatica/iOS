//
//  AgeConfirmViewController.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/22/21.
//

import UIKit

class AgeConfirmViewController: UIViewController {
    // MARK: - Properties
    private var presenter: AgeConfirmPresenterProtocol!
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "AgeConfirmScreenBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.center = view.center
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Intimatica_title")
        return imageView
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n("AGE_CONFIRM_WELCOME_LABEL")
        label.textColor = .white
        label.font = .rubik(fontSize: .subTitle, fontWeight: .bold)
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    
    private lazy var termsView = TermsAndConditionsView(with: L10n("AGE_CONFIRM_TERMS_LABEL"),
                                                        highlightedText: L10n("AGE_CONFIRM_TERMS_LABEL_ATTRIBUTED"),
                                                        action: { [weak self] in
                                                            self?.presenter.showTerms()
                                                        })
    
    private lazy var conditionsView = TermsAndConditionsView(with: L10n("AGE_CONFIRM_CONDITIONS_LABEL"),
                                                             highlightedText: L10n("AGE_CONFIRM_CONDITIONS_LABEL_ATTRIBUTED"),
                                                             action: { [weak self] in
                                                                 self?.presenter.showConditions()
                                                             })
    
    private lazy var continueButton: UIRoundedButton = {
        let button = UIRoundedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n("AGE_CONFIRM_CONTINUE_BUTTON"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundColor(.appYellow, for: .normal)
        button.setTitleColor(Constants.continueButtonTitleColorForDisabled, for: .disabled)
        button.setBackgroundColor(Constants.continueButtonBackgroundColorForDisabled, for: .disabled)
        button.isEnabled = false
        button.titleLabel?.font = .rubik(fontWeight: .bold)
        return button
    }()
    
    // MARK: - Initializers
    init(presenter: AgeConfirmPresenterProtocol) {
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
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Layout
    private func setupView() {
        view.addSubview(backgroundImage)
        view.addSubview(containerView)
        
        containerView.addSubview(titleImage)
        containerView.addSubview(welcomeLabel)
        containerView.addSubview(termsView)
        containerView.addSubview(conditionsView)
        containerView.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleImage.heightAnchor.constraint(equalToConstant: Constants.titleImageHeight),
            titleImage.widthAnchor.constraint(equalTo: titleImage.heightAnchor, multiplier: Constants.titleImageRatio),
            titleImage.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -Constants.titleImageBottom),
            titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            containerView.widthAnchor.constraint(equalToConstant: Constants.containerViewWidth),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            welcomeLabel.heightAnchor.constraint(equalToConstant: Constants.welcomeLabelHeight),
            welcomeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            welcomeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            termsView.heightAnchor.constraint(equalToConstant: Constants.termsAndConditionsHeight),
            termsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            termsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            termsView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Constants.termsTop),
            termsView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            conditionsView.heightAnchor.constraint(equalToConstant: Constants.termsAndConditionsHeight),
            conditionsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            conditionsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            conditionsView.topAnchor.constraint(equalTo: termsView.bottomAnchor, constant: Constants.conditionsTop),
            conditionsView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            continueButton.heightAnchor.constraint(equalToConstant: Constants.continueButtonHeight),
            continueButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            continueButton.topAnchor.constraint(equalTo: conditionsView.bottomAnchor, constant: Constants.continueButtonTop),
            continueButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupActions() {
        termsView.button.addAction { [weak self] in
            guard let self = self else { return }
            self.termsView.button.isSelected = self.termsView.button.isSelected ? false : true
            self.continueButton.isEnabled = self.termsView.button.isSelected && self.conditionsView.button.isSelected ? true : false
        }
        
        conditionsView.button.addAction { [weak self] in
            guard let self = self else { return }
            self.conditionsView.button.isSelected = self.conditionsView.button.isSelected ? false : true
            self.continueButton.isEnabled = self.termsView.button.isSelected && self.conditionsView.button.isSelected ? true : false
        }
        
        continueButton.addAction { [weak self] in
            self?.presenter.continueButtonDidTap()
        }
    }
}

// MARK: - Helper/Constraints
extension AgeConfirmViewController {
    private struct Constants {
        static let continueButtonTitleColorForDisabled = UIColor(hex: 0x9764FF)
        static let continueButtonBackgroundColorForDisabled = UIColor(hex: 0x5C23D1)
        
        static let titleImageBottom: CGFloat = 20
        static let titleImageHeight: CGFloat = 30
        static let titleImageRatio: CGFloat = 277.5 / 42.75
        
        static let containerViewWidth: CGFloat = 270
        
        static let welcomeLabelHeight: CGFloat = 120
        
        static let termsAndConditionsHeight: CGFloat = 30
        static let termsTop: CGFloat = 40
        static let conditionsTop: CGFloat = 20
        
        static let continueButtonHeight: CGFloat = 50
        static let continueButtonTop: CGFloat = 30
    }
}

