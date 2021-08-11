//
//  CategoryFilter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/11/21.
//

import Foundation

enum FeedCategoryFilter: String, CaseIterable {
    case all = "Все"
    case theory = "Теория"
    case story = "Истории"
    case video = "Видео"
    case favorite = "Избранное"
    case hello1 = "Hello #1"
    case hello2 = "Hello #2"
    case hello3 = "Hello #3"
    case hello4 = "Hello #4"
    
    static func toArray() -> [String] {
        FeedCategoryFilter.allCases.map {
            $0.rawValue
        }
    }
}
