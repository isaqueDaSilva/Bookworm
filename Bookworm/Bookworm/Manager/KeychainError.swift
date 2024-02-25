//
//  KeychainError.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/02/24.
//

import Foundation

/// Errors that may occur when communicating with Keychain.
enum KeychainError: Error, LocalizedError, Identifiable {
    /// Error that can occur when there is an attempt to send invalid data.
    case badData
    
    /// Some unknown error that was returned at runtime.
    case unknonw(OSStatus)
    
    /// Error that can occur when we perform a search and there is no match with any of the data.
    case itemNotFound
    
    /// Error that can occur when an attempt to transform a saved Data type into a String type is not possible.
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
