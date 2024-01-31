//
//  User.swift
//  Bookworm
//
//  Created by Isaque da Silva on 19/01/24.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: UUID
    let name: String
    let username: String
    let email: String
    let authors: [Author]
}

extension User {
    struct CreateUser: Codable, Hashable {
        let name: String
        let username: String
        let email: String
        let password: String
        let confirmPassword: String
    }
}

extension User {
    struct UpadateUser: Codable, Hashable {
        let username: String?
    }
}


extension User {
    struct Login: Codable, Hashable {
        let email: String
        let password: String
    }
}
