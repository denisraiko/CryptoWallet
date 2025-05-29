//
//  CryptoListViewModelDelegate.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 26.05.25.
//

import Foundation

protocol CryptoListViewModelDelegate: AnyObject {
    func didUpdateCryptos()
    func didStartLoading()
    func didFinishLoading()
}
