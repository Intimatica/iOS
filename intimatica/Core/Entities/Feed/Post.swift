//
//  Story.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import Foundation

enum PostType: String {
    case theory = "ComponentPostTypeTheory"
    case video = "ComponentPostTypeVideo"
    case story = "ComponentPostTypeStory"
    case videoCourse = "ComponentPostTypeVideoCourse"
}

struct Post {
    let id: Int
    let title: String
    let type: PostType
    let imageUrl: String
    let tags: [String]
}
