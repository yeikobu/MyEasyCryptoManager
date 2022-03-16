//
//  CoinModel.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 09-03-22.
//

import Foundation


struct CoinsModel: Decodable, Hashable {
    var coins: [Coin]
}

struct Coin: Decodable, Hashable {
    var id: String
    var symbol: String
    var name: String
    var image: String
    var currentPrice: Float
    var marketCap: Float
    var marketCapRank: Int
    var fullyDilutedValuation: Int?
    var fully_diluted_valuation: Float
    var high24H: Float
    var low24H: Float
    var priceChange24H: Float
    var priceChangePercentage24H: Float
    var marketCapChange24H: Float
    var marketCapChangePercentage24H: Float
    var circulatingSupply: Float
    var totalSupply: Float?
    var maxSupply: Float
    var ath: Float
    var athChangePercentage: Float
    var athDate: String
    var atl: Float
    var atlChangePercentage: Float
    var atlDate: String
    var roi: Roi
    var lastUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case fully_diluted_valuation = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
    }
}



struct Roi: Decodable, Hashable {
    var times: Float
    var currency: String
    var percentage: Float
}
