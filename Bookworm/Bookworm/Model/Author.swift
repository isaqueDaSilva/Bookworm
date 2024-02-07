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
    
    func getAll(token: Token) async throws -> [Author] {
        let endpoint = "http://127.0.0.1:8080/author/all"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HTTPMethod.get.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode([Author].self, from: data)
    }
}

extension Author {
    struct CreateAuthor: Codable, Hashable {
        let authorName: String
        
        func create(token: Token) async throws -> Author {
            let endpoint = "http://127.0.0.1:8080/author/create"
            
            guard let url = URL(string: endpoint) else {
                throw NetworkError.invalidURL
            }
            
            let newAuthor = try JSONEncoder().encode(self)
            
            var request = URLRequest(url: url)
            request.addValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
            request.httpMethod = HTTPMethod.post.rawValue
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: newAuthor)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
            
            return try JSONDecoder().decode(Author.self, from: data)
        }
    }
}

extension Author {
    struct UpadateAuthor: Codable, Hashable {
        let authorName: String?
    }
}
