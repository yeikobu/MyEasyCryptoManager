//
//  FavouriteCoinModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 04-04-22.
//

import Foundation

struct FavouriteCoinModel: Decodable, Hashable, Encodable {
    var id: String?
    var name: String?
    var symbol: String?
    var imgURL: String?
    var purchasePrice: Double?
    var purchaseQuantity: Double?
    var currentPrice: Double?
    var priceChangePercentage24h: Double?
}
