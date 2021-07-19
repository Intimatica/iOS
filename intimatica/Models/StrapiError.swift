//
//  StrapiError.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/19/21.
//

import Foundation

// MARK: - StrapiError
struct StrapiError: Codable {
    let statusCode: Int
    let error: String
    let message: [Datum]
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let id: String
    let message: String
}
