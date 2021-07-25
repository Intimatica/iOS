//
//  SingUpModel.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/19/21.
//

import Foundation

struct AuthResponse: Decodable {
    let jwt: String
    let user: User
}

// MARK: - User
extension AuthResponse {
    struct User: Decodable {
        let id: Int
        let username: String?
        let email: String
        let provider: String
        let confirmed: Bool
        let blocked: Bool?
        let role: Role
        let createdAt: String
        let updatedAt: String

        enum CodingKeys: String, CodingKey {
            case id, username, email, provider, confirmed, blocked, role
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
}

// MARK: - Role
extension AuthResponse {
    struct Role: Decodable {
        let id: Int
        let name: String
        let description: String
        let type: String
    }
}
