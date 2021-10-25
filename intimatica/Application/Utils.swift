//
//  Utils.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/21/21.
//

import Foundation

func L10n(_ text: String) -> String {
//    NSLocalizedString(text, comment: "")
    
    guard let path = Bundle.main.path(forResource: AppConstants.language, ofType: "lproj"),
          let bundle = Bundle(path: path)
    else {
        return text
    }

    return bundle.localizedString(forKey: text, value: "", table: nil)
}
