//
//  KeychainManager.swift
//  Bookworm
//
//  Created by Isaque da Silva on 17/02/24.
//

import Foundation
import Security

struct Keychain {
    @discardableResult
    static func save(service: String, tokenData: Data) throws -> OSStatus {
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecValueData as String: tokenData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            try self.delete(service: service)
        }
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateItem("There are two identical keys saved.")
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
