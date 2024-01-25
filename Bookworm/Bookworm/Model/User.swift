//
//  User.swift
//  Bookworm
//
//  Created by Isaque da Silva on 19/01/24.
//

import Foundation

struct User: Codable, Identifiable { 
    let id: UUID
    let name: String
    let username: String
    let email: String
    let authors: [Author]
}

extension User {
    struct CreateUser: Codable {
        let name: String
        let username: String
        let email: String
        let password: String
        let confirmPassword: String
    }
}

extension User {
    struct UpadateUser: Codable {
        let username: String?
        let email: String?
    }
}


extension User {
    struct Login: Codable {
        let email: String
        let password: String
    }
}
