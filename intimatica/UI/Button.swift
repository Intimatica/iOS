//
//  Button.swift
//  intimatica
//
//  Created by Andrey RustFox on 10/6/21.
//

import Foundation
import UIKit

struct Button {
    static func backBarButtonItem() -> UIBarButtonItem {
        let barButton = UIBarButtonItem(image: UIImage(named: "back_button"),
                                        style: .plain,
                                        target: nil,
                                        action: #selector(UINavigationController.popViewController(animated:)))
        barButton.tintColor = .appDarkPurple
        return barButton
    }
}
