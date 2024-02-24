//
//  KeychainError.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/02/24.
//

import Foundation

enum KeychainError: Error, LocalizedError, Identifiable {
    case badData
    case unknonw(OSStatus)
    case itemNotFound
    case unableToConvertToString
    
    var id: String {
        self.localizedDescription
    }
    
    var errorDescription: String? {
        switch self {
        case .badData:
            return NSLocalizedString("The data received is not valid, please try again..", comment: "")
        case .unknonw(let status):
            return NSLocalizedString("An unknown error has occurred, please try again.", comment: status.description)
        case .itemNotFound:
            return NSLocalizedString("No items found. Please try logging in again.", comment: "")
        case .unableToConvertToString:
            return NSLocalizedString("It was not possible to convert some data for internal use of the App, please try again.", comment: "")
        }
    }
}
