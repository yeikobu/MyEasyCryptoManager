//
//  GlobalMarketModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 18-03-22.
//

import Foundation

struct GlobalMarketModel: Decodable, Hashable {
    var data: DataClass?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct DataClass: Decodable, Hashable {
    var activeCryptocurrencies: Int?
    var upcomingIcos: Int?
    var ongoingIcos: Int?
    var endedIcos: Int?
    var markets: Int?
    var totalMarketCap, totalVolume, marketCapPercentage: [String: Double]?
    var marketCapChangePercentage24HUsd: Double?
    var updatedAt: Int?
    
    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
}
