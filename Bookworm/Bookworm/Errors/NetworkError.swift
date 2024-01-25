//
//  Errors.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/01/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case failedToEncodeData
}
