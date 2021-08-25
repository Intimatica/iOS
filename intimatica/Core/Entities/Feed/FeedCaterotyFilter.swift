//
//  CategoryFilter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/11/21.
//

import Foundation

enum FeedCategory: String, CaseIterable {
    case all = "Все"
    case theory = "Теория"
    case story = "Истории"
    case video = "Видео"
    case favorite = "Избранное"
    case allCourses = "Все курсы"
    case myCourses = "Мои курсы"
    
    static func toArray() -> [String] {
        FeedCategory.allCases.map {
            $0.rawValue
        }
    }
}
