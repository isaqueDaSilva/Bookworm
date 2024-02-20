//
//  NetworkError.swift
//  Bookworm
//
//  Created by Isaque da Silva on 17/02/24.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL(String)
    case invalidResponse(String)
    case invalidData(String)
    case failedToEncodeData(String)
    case failedToGetData(String)
}
