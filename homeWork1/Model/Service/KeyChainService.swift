//
//  KeyChainService.swift
//  homeWork1
//
//  Created by Chinara on 6/30/23.
//

import Foundation

final class KeyChainService {
    
    func addPassword(service: String, account: String, password: String) {
        let query = [
            kSecValueData: service,
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: password
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            print("Error: \(status)")
        }
    }
    
    func readPassword(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return (result as? Data)
    }
    
    func updatePassword(service: String, account: String, newPassword: String) {
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: service] as CFDictionary
            
            SecItemUpdate(query, attributesToUpdate)
    }
    
    func delete(service: String, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        SecItemDelete(query)
    }
 
}
