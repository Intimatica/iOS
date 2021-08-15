//
//  Array+Utils.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/9/21.
//

import Foundation

extension Array where Element: Equatable {
    func isLast(element: Element) -> Bool {
        element == last
    }
}
