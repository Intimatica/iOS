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
}
