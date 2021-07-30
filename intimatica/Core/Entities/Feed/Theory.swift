//
//  Story.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/29/21.
//

import Foundation

class Theory: Post {
    let content: String?
    
    init(post: Post, content: String) {
        self.content = content
        super.init(by: post)
    }
}
