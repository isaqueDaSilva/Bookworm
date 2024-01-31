//
//  Author.swift
//  Bookworm
//
//  Created by Isaque da Silva on 18/11/23.
//

import Foundation

struct Author: Codable, Identifiable, Hashable {
    let id: UUID
    let authorName: String
    let books: [Book]
    let user: UUID
}

extension Author {
    struct CreateAuthor: Codable, Hashable {
        let authorName: String
    }
}

extension Author {
    struct UpadateAuthor: Codable, Hashable {
        let authorName: String?
    }
}
