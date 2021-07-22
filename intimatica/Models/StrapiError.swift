//
//  StrapiError.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/19/21.
//

import Foundation

/**
 Pay attantion rate limit error message doesn't have statusCode, error and data field
 */

// MARK: - StrapiError
struct StrapiError: Decodable {
//    let statusCode: Int
//    let error: String
    let message: [Datum]
//    let data: [Datum]
}

// MARK: - Datum
extension StrapiError {
    struct Datum: Decodable {
        let messages: [Message]
    }
}

// MARK: - Message
extension StrapiError {
    struct Message: Decodable {
        let id: String
        let message: String
    }
}
