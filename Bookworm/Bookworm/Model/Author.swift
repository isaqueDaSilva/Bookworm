//
//  Author.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation
import SwiftData

@Model
final class Author: Codable {
    @Attribute(.unique)
    let id: UUID?
    
    @Attribute(.unique)
    var authorName: String
    
    @Relationship(deleteRule: .cascade)
    var books: [Book]
    
    enum CodingKeys: String, CodingKey {
        case id
        case authorName = "author_name"
        case books
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(authorName, forKey: .authorName)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.authorName = try container.decode(String.self, forKey: .authorName)
        self.books = try container.decode([Book].self, forKey: .books)
    }
    
    init(id: UUID? = nil, authorName: String, books: [Book] = []) {
        self.id = id
        self.authorName = authorName
        self.books = books
    }
}

extension Author: Hashable { 
    static func == (lhs: Author, rhs: Author) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
