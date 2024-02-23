//
//  User.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation
import SwiftData

@Model
final class User: Codable {
    @Attribute(.unique)
    var id: UUID?
    
    var name: String
    var username: String
    
    @Attribute(.unique)
    var email: String
    
    @Relationship(deleteRule: .cascade)
    var author: [Author]
    
    enum CodingKeys: String, CodingKey {
        case id, name, username, email, author
    }
    
    init(id: UUID? = nil, name: String, username: String, email: String, author: [Author] = []) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.author = author
    }
    
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try value.decode(UUID.self, forKey: .id)
        self.name = try value.decode(String.self, forKey: .name)
        self.username = try value.decode(String.self, forKey: .username)
        self.email = try value.decode(String.self, forKey: .email)
        self.author = try value.decode([Author].self, forKey: .author)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
    }
}
