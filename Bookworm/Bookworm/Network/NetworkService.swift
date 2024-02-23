//
//  NetworkService.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation

struct NetworkService {
    static func request(
        endpoint: String,
        requestValue: String? = nil,
        for headerField: String? = nil,
        postData: Data? = nil,
        httpMethod: HTTPMethod
    ) async throws -> Data {
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        if (requestValue != nil) && (headerField != nil) {
            guard let value = requestValue else {
                throw NetworkError.invalidRequestValue
            }
            
            guard let field = headerField else {
                throw NetworkError.invalidRequestValue
            }
            
            request.addValue(value, forHTTPHeaderField: field)
        }
        
        if (postData != nil) {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let uploadData = postData else {
                throw NetworkError.faliedToGetData
            }
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: uploadData)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
            
            return data
        } else {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
            
            return data
        }
    }
}
