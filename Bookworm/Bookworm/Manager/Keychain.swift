//
//  Keychain.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/02/24.
//

import Foundation
import Security

struct Keychain {
    static func create(
        account: String,
        service: String,
        tokenValue: String
    ) throws {
        guard let tokenData = tokenValue.data(using: .utf8) else {
            throw KeychainError.badData
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: tokenData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            try self.update(
                account: account,
                service: service,
                tokenValue: tokenValue
            )
        default:
            throw KeychainError.unknonw(status)
        }
    }
    
    static func read(
        account: String,
        service: String
    ) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknonw(status)
        }
        
        guard
            let existingItem = item as? [String: Any],
            let tokenData = existingItem[kSecValueData as String] as? Data,
            let tokenValue = String(data: tokenData, encoding: .utf8)
        else {
            throw KeychainError.unableToConvertToString
        }
        
        return tokenValue
    }
    
    private static func update(
        account: String,
        service: String,
        tokenValue: String
    ) throws {
        guard let tokenData = tokenValue.data(using: .utf8) else {
            throw KeychainError.badData
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: tokenData
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknonw(status)
        }
    }
    
    static func delete(
        account: String,
        service: String
    ) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unknonw(status)
        }
    }
}
