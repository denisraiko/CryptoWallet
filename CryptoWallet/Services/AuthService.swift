//
//  AuthService.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 24.05.25.
//

import Foundation

final class AuthService {
    
    private enum Keys {
        static let isLoggedIn = "isLoggedIn"
        static let username = "username"
    }
    
    // MARK: - Авторизация
    
    static func isLoggedIn() -> Bool {
        return KeychainService.get(key: Keys.isLoggedIn) == "true"
        
    }
    
    static func setLoggedIn(_ value: Bool, username: String? = nil) {
        KeychainService.save(key: Keys.isLoggedIn, value: value ? "true" : "false")
        
        if let username = username {
            KeychainService.save(key: Keys.username, value: username)
        }
    }
    
    static func logout() {
        KeychainService.delete(key: Keys.isLoggedIn)
        KeychainService.delete(key: Keys.username)
    }
}
