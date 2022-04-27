//
//  SearchCoinModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 26-04-22.
//

import Foundation

// MARK: - SearchCoinModel
struct SearchCoinModel: Decodable, Hashable {
    let coins: [Coin?]
    let exchanges: [Exchange?]
    let icos: [String?]
    let categories: [Category?]
    let nfts: [Nft?]
}

// MARK: - Category
struct Category: Decodable, Hashable {
    let id: Int?
    let name: String?
}

// MARK: - Coin
struct Coin: Decodable, Hashable {
    let id, name, symbol: String?
    let marketCapRank: Int?
    let thumb, large: String?

    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case marketCapRank = "market_cap_rank"
        case thumb, large
    }
}

// MARK: - Exchange
struct Exchange: Decodable, Hashable {
    let id, name, marketType: String?
    let thumb, large: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case marketType = "market_type"
        case thumb, large
    }
}

// MARK: - Nft
struct Nft: Decodable, Hashable {
    let id: String?
    let name, symbol: String?
    let thumb: String?
}
