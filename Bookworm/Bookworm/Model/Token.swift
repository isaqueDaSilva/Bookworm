//
//  Token.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/01/24.
//

import Foundation

struct Token: Codable {
    let id: UUID
    let value: String
    
    func getUser() async throws -> User {
        let endpoint = "http://127.0.0.1:8080/user/profile"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(self.value)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HTTPMethod.get.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(User.self, from: data)
    }
    
    func signOut() async throws {
        let endpoint = "http://127.0.0.1:8080/user/logout"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(self.value)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HTTPMethod.delete.rawValue
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
    }
}
