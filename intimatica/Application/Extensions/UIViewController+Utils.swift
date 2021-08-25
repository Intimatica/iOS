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

fileprivate var spinnerView: UIView?

// MARK: Helper/Spinner
extension UIViewController {

    func showSpinner() {
        showSpinner(frame: self.view.bounds)
    }
    
    func showSpinner(frame: CGRect, opacity: CGFloat = 1) {
        spinnerView = UIView(frame: frame)
        
        guard let spinnerView = spinnerView else { return }
        
        if opacity != 1 {
            spinnerView.backgroundColor = .black.withAlphaComponent(opacity)
        } else {
            spinnerView.backgroundColor = .white
        }
        
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = spinnerView.center
        activityIndicator.startAnimating()
        spinnerView.addSubview(activityIndicator)
        self.view.addSubview(spinnerView)
        
    }
    
    func hideSpinner() {
        UIView.animate(withDuration: 0.3, animations: {
            spinnerView?.alpha = 0
        }, completion: { _ in
            spinnerView?.removeFromSuperview()
            spinnerView = nil
        })
    }
}
