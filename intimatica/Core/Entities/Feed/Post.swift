//
//  Story.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/26/21.
//

import Foundation

enum PostType: String {
    case theory = "Theory"
    case video = "Video"
    case story = "Story"
    case videoCourse = "Course"
}

class Post {
    let id: Int
    let title: String
    let type: PostType
    let imageUrl: String
    let tags: [String]
    let isPaid: Bool
    
    init(id: Int, title: String, type: PostType, imageUrl: String, tags: [String], isPaid: Bool) {
        self.id = id
        self.title = title
        self.type = type
        self.imageUrl = imageUrl
        self.tags = tags
        self.isPaid = isPaid
    }
    
    init(by post: Post) {
        self.id = post.id
        self.title = post.title
        self.type = post.type
        self.imageUrl = post.imageUrl
        self.tags = post.tags
        self.isPaid = post.isPaid
    }
}
