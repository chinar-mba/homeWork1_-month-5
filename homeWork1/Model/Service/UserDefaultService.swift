//
//  UserDefaultService.swift
//  homeWork1
//
//  Created by Chinara on 6/30/23.
//

import Foundation

final class UserDefaultService {
    
    enum UserDefaultKeys: String {
        case color
    }
    
    static let shared = UserDefaultService()
    private let userDefault = UserDefaults.standard
    
    private init() { }
    
    func save(_ item: Any, forKey key: UserDefaultKeys) {
        userDefault.set(item, forKey: key.rawValue)
    }
    
    func string(forKey key: UserDefaultKeys) -> String? {
        userDefault.string(forKey: key.rawValue)
    }
    
    func remove(forKey key: UserDefaultKeys) {
        userDefault.removeObject(forKey: key.rawValue)
    }
}

