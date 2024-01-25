//
//  KeychainError.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/01/24.
//

import Foundation
import Security

enum KeychainError: Error {
    case duplicateItem
    case unknown(OSStatus)
}
