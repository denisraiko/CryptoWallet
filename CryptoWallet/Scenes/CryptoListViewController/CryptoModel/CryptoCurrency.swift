//
//  CryptoCurrency.swift
//  CryptoWallet
//
//  Created by Denis Raiko on 25.05.25.
//

import Foundation

struct CryptoCurrency {
    let name: String
    let symbol: String
    let price: Double
    let change: Double
    let cryptoData: CryptoData
}

struct CryptoResponse: Decodable {
    let data: CryptoData
}

struct CryptoData: Decodable {
    let name: String
    let symbol: String
    let market_data: MarketData
    let marketcap: MarketCap
    let supply: Supply
}

struct MarketData: Decodable {
    let price_usd: Double
    let percent_change_usd_last_24_hours: Double

    enum CodingKeys: String, CodingKey {
        case price_usd = "price_usd"
        case percent_change_usd_last_24_hours = "percent_change_usd_last_24_hours"
    }
}

struct MarketCap: Decodable {
    let current_marketcap_usd: Double
    
    enum CodingKeys: String, CodingKey {
        case current_marketcap_usd = "current_marketcap_usd"
    }
}

struct Supply: Decodable {
    let circulating: Double
    
    enum CodingKeys: String, CodingKey {
        case circulating = "circulating"
    }
}

extension CryptoCurrency {
    init(from data: CryptoData) {
        self.name = data.name
        self.symbol = data.symbol
        self.price = data.market_data.price_usd
        self.change = data.market_data.percent_change_usd_last_24_hours
        self.cryptoData = data
    }
}
