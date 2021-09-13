//
//  String+Utils.swift
//  intimatica
//
//  Created by Andrey RustFox on 9/9/21.
//

import Foundation

extension StringProtocol {
    func uppercaseFirstLetter() -> String {
        prefix(1).uppercased() + dropFirst()
    }
}
