//
//  Result+NetworkService.swift
//  Bookworm
//
//  Created by Isaque da Silva on 17/02/24.
//

import Foundation

extension Result {
    static func loginUser(email: String, password: String) async throws -> Result {
        try await AuthenticationManager.login(email: email, password: password)
        
        return try await fetchUser()
    }
    
    static func fetchUser() async throws -> Result {
        let token = try AuthenticationManager.getTokenValue()
        
        let data = try await NetworkRequest.request(
            endpoint: APIEndpoints.getUserProfile.rawValue,
            requestValue: "\(RequestValue.bearer.rawValue) \(token)",
            for: HeaderField.authorization.rawValue,
            httpMethod: .get
        )
        
        return try JSONDecoder().decode(Result.self, from: data)
    }
}
