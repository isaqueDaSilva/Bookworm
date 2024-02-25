//
//  NetworkService.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation

struct NetworkService {
    
    /// This method handle with the every REST API call
    /// - Parameters:
    ///   - endpoint: The API endpoint we will use to make the request.
    ///   - requestValue: Represents the value that will be use for header field.
    ///   - headerField: The name of the header field.
    ///   - postData: The data will be send, when the request is POST or PATCH.
    ///   - httpMethod: Represent the HTTP method will be used in request(GET, POST, PATCH, DELETE).
    /// - Returns: Return a JSON representing the data for the request
    static func request(
        endpoint: String,
        requestValue: String? = nil,
        for headerField: String? = nil,
        postData: Data? = nil,
        httpMethod: HTTPMethod
    ) async throws -> Data {
        // Checks if the endpoint is valid
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        // Create a URLRequest with the URL
        // that was obtained from the endpoint.
        var request = URLRequest(url: url)
        
        // If request value and header field isn't nil,
        // will be passed for "addValue" method
        // from the URLRequest instance
        if (requestValue != nil) && (headerField != nil) {
            guard let value = requestValue else {
                throw NetworkError.invalidRequestValue
            }
            
            guard let field = headerField else {
                throw NetworkError.invalidRequestValue
            }
            
            request.addValue(value, forHTTPHeaderField: field)
        }
        
        // If the post data isn't nil, will be set a "addValue" method
        // with a value and a field name specific for handle with
        // the send of a JSON on "URLSession.shared.upload(for:from:)".
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
            // we will proceed to request data via "URLSession.shared.data(for:)"
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
            
            return data
        }
    }
}
