//
//  CryptoService.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 26.05.25.
//

import Foundation

final class CryptoService {

    private let baseURL = "https://data.messari.io/api/v1/assets"
    private let session = URLSession.shared
    private let syncQueue = DispatchQueue(label: "crypto.service.sync.queue")

    private let symbols = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]

    func fetchCryptos(completion: @escaping (Result<[CryptoCurrency], Error>) -> Void) {
        var results: [CryptoCurrency] = []
        let group = DispatchGroup()
        var fetchError: Error?

        for symbol in symbols {
            group.enter()

            let urlString = "\(baseURL)/\(symbol)/metrics"
            guard let url = URL(string: urlString) else {
                group.leave()
                continue
            }

            session.dataTask(with: url) { data, response, error in
                defer { group.leave() }

                if let error = error {
                    self.syncQueue.async {
                        if fetchError == nil {
                            fetchError = error
                        }
                    }
                    return
                }

                guard let data = data else {
                    self.syncQueue.async {
                        if fetchError == nil {
                            fetchError = NSError(domain: "CryptoService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                        }
                    }
                    return
                }

                do {
                    let response = try JSONDecoder().decode(CryptoResponse.self, from: data)
                    let crypto = CryptoCurrency(from: response.data)
                    self.syncQueue.async {
                        results.append(crypto)
                    }
                } catch {
                    self.syncQueue.async {
                        if fetchError == nil {
                            fetchError = error
                        }
                    }
                }

            }.resume()
        }

        group.notify(queue: .main) {
            if let error = fetchError {
                completion(.failure(error))
            } else {
                completion(.success(results))
            }
        }
    }
}
