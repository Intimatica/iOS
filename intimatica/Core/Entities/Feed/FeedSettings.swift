//
//  FeedSettings.swift
//  intimatica
//
//  Created by Andrey RustFox on 8/20/21.
//

import Foundation

protocol FeedSettings {
    var tabBarTitle: String { get }
    var tabBarImageName: String { get }
}

struct PostFeedSettings: FeedSettings {
    let tabBarTitle = L10n("POST_LIST_TABBAR_ITEM_TITLE")
    let tabBarImageName = "posts"
}

struct CourseFeedSettings: FeedSettings {
    let tabBarTitle = L10n("COURSES_TABBAR_ITEM_TITLE")
    let tabBarImageName = "courses"
}
