//
//  LoginViewModel.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 24.05.25.
//

import Foundation

final class LoginViewModel {
    
    // MARK: Delegate
    
    weak var delegate: LoginViewModelDelegate?
    
    func login(userName: String, password: String) {
        let validUserName = "1234"
        let validPassword = "1234"
        
        if userName == validUserName && password == validPassword {
            AuthService.setLoggedIn(true)
            delegate?.loginDidSucceed()
        } else {
            delegate?.loginDidFail()
        }
    }
}
