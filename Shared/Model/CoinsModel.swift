//
//  CoinModel.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 09-03-22.
//

import Foundation

struct CoinsModel: Decodable, Hashable {
    var id: String? = ""
    var symbol: String? = ""
    var name: String? = ""
    var image: String? = ""
    var currentPrice: Double? = 0
    var marketCap: Int? = 0
    var marketCapRank: Int? = 0
    var fullyDilutedValuation: Int? = 0
    var totalVolume: Double? = 0
    var high24H: Double? = 0
    var low24H: Double? = 0
    var priceChange24H: Double? = 0
    var priceChangePercentage24H: Double? = 0
    var marketCapChange24H: Double? = 0
    var marketCapChangePercentage24H: Double? = 0
    var circulatingSupply: Double? = 0
    var totalSupply: Double? = 0
    var maxSupply: Double? = 0
    var ath: Double? = 0
    var athChangePercentage: Double? = 0
    var athDate: String?  = ""
    var atl: Double? = 0
    var atlChangePercentage: Double? = 0
    var atlDate: String? = ""
    var lastUpdated: String? = ""
    var sparkLine7D: SparkLine7D?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
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
        case lastUpdated = "last_updated"
        case sparkLine7D = "sparkline_in_7d"
    }
}

struct SparkLine7D: Decodable, Hashable {
    var price: [Double]? = []
    
    enum CodingKeys: String, CodingKey {
        case price 
    }
}
