//
//  StorageError.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation

enum StorageError: Error, LocalizedError, Identifiable {
    case dataNotFound
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
