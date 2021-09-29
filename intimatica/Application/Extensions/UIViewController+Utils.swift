//
//  UIViewController+Extension.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

extension UIViewController {
    func showError(_ message: String, title: String = L10n("ERROR")) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n("OK"), style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func enableHideKeyboardOnTap() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

protocol ActivityIndicatable {
    var activityContainerView: UIView { get }
}

extension ActivityIndicatable where Self: UIViewController {
    func showActivityIndicator() {
        showActivityIndicator(with: view.frame)
    }
    
    func showActivityIndicator(with frame: CGRect, opacity: CGFloat = 1.0) {
        activityContainerView.frame = frame
        activityContainerView.backgroundColor = opacity != 1 ? .black.withAlphaComponent(opacity) : .white
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = activityContainerView.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityContainerView.addSubview(activityIndicator)
        view.addSubview(activityContainerView)
    }

    func hideActivityIndicator() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.activityContainerView.alpha = 0
        }, completion: { [weak self] _ in
            self?.activityContainerView.removeFromSuperview()
        })
    }
}

extension UIViewController {
    func hideNavigationBarBottomLine() {
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearence = UINavigationBarAppearance()
        navigationBarAppearence.shadowColor = .clear
        navigationBar?.scrollEdgeAppearance = navigationBarAppearence
        
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
