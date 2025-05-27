//
//  LoginViewModelDelegate.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 24.05.25.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func loginDidSucceed()
    func loginDidFail()
}
