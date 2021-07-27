//
//  Story.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import Foundation

enum PostType: String {
    case theory
    case video
    case story
}

struct Post {
    let id: Int
    let title: String
    let type: PostType
    let imageUrl: String
    let tags: [String]
}
