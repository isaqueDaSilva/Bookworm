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
    
    func delete(token: Token) async throws {
        let endpoint = "http://127.0.0.1:8080/user/delete"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HTTPMethod.delete.rawValue
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
    }
}

extension User {
    struct CreateUser: Codable, Hashable {
        let name: String
        let username: String
        let email: String
        let password: String
        let confirmPassword: String
        
        func create() async throws {
            let endpoint = "http://127.0.0.1:8080/user/create"
            
            guard let url = URL(string: endpoint) else {
                throw NetworkError.invalidURL
            }
            
            let user = try JSONEncoder().encode(self)
            
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            
            let (_, response) = try await URLSession.shared.upload(for: request, from: user)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
        }
    }
}

extension User {
    struct UpadateUser: Codable, Hashable {
        let username: String?
        
        func update(token: Token) async throws -> User {
            let endpoint = "http://127.0.0.1:8080/user/update"
            
            guard let url = URL(string: endpoint) else {
                throw NetworkError.invalidURL
            }
            
            let userUpdated = try JSONEncoder().encode(self)
            
            var request = URLRequest(url: url)
            request.addValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
            request.httpMethod = HTTPMethod.patch.rawValue
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: userUpdated)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
            
            return try JSONDecoder().decode(User.self, from: data)
        }
    }
}


extension User {
    struct Login: Codable, Hashable {
        let email: String
        let password: String
        
        func getTokenData() async throws -> Data {
            let endpoint = "http://127.0.0.1:8080/user/login"
            
            guard let url = URL(string: endpoint) else {
                throw NetworkError.invalidURL
            }
            
            let userCredentials = try JSONEncoder().encode(self).base64EncodedString()
            
            var request = URLRequest(url: url)
            request.addValue("Basic \(userCredentials)", forHTTPHeaderField: "Authorization")
            request.httpMethod = HTTPMethod.post.rawValue
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
            
            return data
        }
    }
}
