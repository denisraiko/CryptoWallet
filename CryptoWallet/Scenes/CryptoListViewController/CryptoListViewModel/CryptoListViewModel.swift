//
//  CryptoListViewModel.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 25.05.25.
//

import Foundation


enum SortOrder {
    case ascending
    case descending
}

final class CryptoListViewModel {
    
    var delegate: CryptoListViewModelDelegate?
    
    private(set) var cryptos: [CryptoCurrency] = []
    
    func fetchCryptos() {
        delegate?.didStartLoading()

        CryptoService().fetchCryptos { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.didFinishLoading()

                switch result {
                case .success(let cryptos):
                    self?.cryptos = cryptos
                    self?.delegate?.didUpdateCryptos()
                case .failure(let error):
                    print("Ошибка загрузки: \(error.localizedDescription)")
                }
            }
        }
    }

    func sortCryptos(by order: SortOrder) {
        switch order {
        case .ascending:
            cryptos.sort { $0.change < $1.change }
        case .descending:
            cryptos.sort { $0.change > $1.change }
        }
        delegate?.didUpdateCryptos()
    }
    
    func refreshData() {
        cryptos.removeAll()
        delegate?.didUpdateCryptos()
        fetchCryptos()
    }
}
