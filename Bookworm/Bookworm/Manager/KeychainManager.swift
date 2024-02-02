//
//  KeychainManager.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/01/24.
//

import Foundation
import Security


final class KeychainManager {
    @discardableResult
    static func save(service: String, token: Token) throws -> OSStatus {
        let tokenData = try JSONEncoder().encode(token)
        
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecValueData as String: tokenData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateItem
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        
        return status
    }
    
    static func load(service: String) throws -> Data? {
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        
        guard let existingItem = item as? [String : Any] else {
            return nil
        }
        
        return existingItem[kSecValueData as String] as? Data
    }
    
    @discardableResult
    static func delete(service: String) throws -> OSStatus {
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        
        return status
    }
}
