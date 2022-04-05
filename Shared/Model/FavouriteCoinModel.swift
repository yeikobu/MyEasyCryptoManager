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
    var currentPrice: Double?
    var priceChangePercentage: Double?
    var valuePerAssetAmount: Double?
    var assetAmount: Double?
}
