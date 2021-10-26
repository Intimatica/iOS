//
//  CategoryFilter.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/11/21.
//

import Foundation

enum FeedCategory: String, CaseIterable {
    case all = "CATEGORY_ALL"
    case theory = "CATEGORY_THEORY"
    case story = "CATEGORY_STORY"
    case video = "CATEGORY_VIDEO"
    case favorite = "CATEGORY_FAVORITE"
    case allCourses = "CATEGORY_ALL_COURSES"
    case myCourses = "CATEGORY_MY_COURSES"
    
    static func toArray() -> [String] {
        FeedCategory.allCases.map {
            $0.rawValue
        }
    }
}
