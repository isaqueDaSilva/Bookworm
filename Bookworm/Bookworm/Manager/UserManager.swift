//
//  BooksManager.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

actor BookwormDataManager {
    var user: User?
    
    func createUser(_ newUser: User.CreateUser) async throws -> User {
        let endpoint = ""
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let dataEncoded = try? JSONEncoder().encode(newUser) else {
            throw NetworkError.failedToEncodeData
        }
        
        let (data, response) = try await URLSession.shared.upload(for: request, from: dataEncoded)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decodeUser = try JSONDecoder().decode(User.self, from: data)
        
        return decodeUser
    }
    
    func login(userCredentials: User.Login) async throws -> Token {
        let endpoint = ""
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        guard let loginString = "\(userCredentials.email):\(userCredentials.password)".data(using: .utf8)?.base64EncodedString() else {
            throw NetworkError.failedToEncodeData
        }
        
        var request = URLRequest(url: url)
        request.addValue("Basic \(loginString)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(Token.self, from: data)
    }
    
    func getUser(token: Token) async throws -> User {
        let endpoint = ""
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(User.self, from: data)
    }
    
    func updateUser(updateUser: User.UpadateUser) async throws -> User {
        let endpoint = ""
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        guard let dataEncoded = try? JSONEncoder().encode(updateUser) else {
            throw NetworkError.failedToEncodeData
        }
        
        let (data, response) = try await URLSession.shared.upload(for: request, from: dataEncoded)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decodeUpdateUser = try JSONDecoder().decode(User.self, from: data)
        
        return decodeUpdateUser
    }
    
    func deleteUser(_ user: User) async throws -> HTTPURLResponse {
        let endpoint = ""
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        guard let dataEncoded = try? JSONEncoder().encode(user) else {
            throw NetworkError.failedToEncodeData
        }
        
        let (_, response) = try await URLSession.shared.upload(for: request, from: dataEncoded)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return response
    }
}
