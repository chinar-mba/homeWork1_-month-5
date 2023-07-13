//
//  KeyChainService.swift
//  homeWork1
//
//  Created by Chinara on 6/30/23.
//

import Foundation

final class KeyChainService {
    
    static let shared = KeyChainService()
    
    func save(
        service: String,
        account: String,
        data: Data
    ) throws {
        let query: [String: AnyObject] = [
            kSecValueData as String: data as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject,
            kSecAttrService as String: service as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            update(
                service: service,
                account: account,
                data: data
            )
            return
        }
        
        guard status == errSecSuccess else {
            print("Error: \(status)")
            return
        }
        print("saved")
    }
    
    func read(
        service: String,
        account: String
    ) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        print(status)
        return result as? Data
    }
    
    func update(
        service: String,
        account: String,
        data: Data
    ) {
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            SecItemUpdate(query, attributesToUpdate)
    }
    
    func delete(
        service: String,
        account: String
    ) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        SecItemDelete(query)
    }
 
}
