//
//  StorageError.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation

/// Error that can happen when communicating with SwiftData.
enum StorageError: Error, LocalizedError, Identifiable {
    /// This error is returned when the search does not find any data corresponding to that desired.
    case dataNotFound
    
    /// This error is returned when, in an attempt to save a new instance of a persistent model,
    /// SwiftData finds an instance identical to the one the user is trying to save.
    case duplicateItem
    
    var id: String {
        self.localizedDescription
    }
    
    var errorDescription: String? {
        switch self {
        case .dataNotFound:
            return NSLocalizedString("We were unable to locate the requested data, please try again.", comment: "")
        case .duplicateItem:
            return NSLocalizedString("This item already exists, please create a new one.", comment: "")
        }
    }
}
