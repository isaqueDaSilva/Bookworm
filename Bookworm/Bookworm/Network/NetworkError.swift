//
//  NetworkError.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation

enum NetworkError: Error, LocalizedError, Identifiable {
    case invalidURL
    case invalidRequestValue
    case invalidHeaderField
    case faliedToGetData
    case invalidResponse
    
    var id: String {
        self.localizedDescription
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL, please contact support.", comment: "")
        case .invalidRequestValue:
            return NSLocalizedString("Invalid request value, please contact support.", comment: "")
        case .invalidHeaderField:
            return NSLocalizedString("Invalid header field, please contact support.", comment: "")
        case .faliedToGetData:
            return NSLocalizedString("Failed to receive data, please try again.", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Invalid receive response, please try again.", comment: "")
        }
    }
}
