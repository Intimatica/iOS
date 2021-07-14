//
//  UIViewController+Extension.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/14/21.
//

import UIKit

extension UIViewController {
    func l10n(_ text: String) -> String {
        NSLocalizedString(text, comment: "")
    }
}
