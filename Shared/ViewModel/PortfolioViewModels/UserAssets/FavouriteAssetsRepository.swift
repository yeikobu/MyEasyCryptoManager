//
//  FavouriteAssetsRepository.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 04-04-22.
//

import Foundation
import CloudKit
import SwiftUI

final class FavouriteAssetsRepository {
    private let favouritesAssetsDataSource: FavouriteAssetsDataSource
    
    init(favouritesAssetsDataSource: FavouriteAssetsDataSource = FavouriteAssetsDataSource()) {
        self.favouritesAssetsDataSource = favouritesAssetsDataSource
    }
    
    func getAllAssets(completionBlock: @escaping (Result<[FavouriteCoinModel], Error>) -> Void) {
        self.favouritesAssetsDataSource.getAllAssets(completionBlock: completionBlock)
    }
    
    func addFavouriteAsset(id: String, name: String, symbol: String, imgURL: String, purchasePrice: Double, purchaseQuantity: Double, currentPrice: Double, priceChangePercentage24h: Double, completionBlock: @escaping (Result<FavouriteCoinModel, Error>) -> Void) {
        self.favouritesAssetsDataSource.addFavouriteAsset(id: id, name: name, symbol: symbol, imgURL: imgURL, purchasePrice: purchasePrice, purchaseQuantity: purchaseQuantity, currentPrice: currentPrice, priceChangePercentage24h: priceChangePercentage24h, completionBlock: completionBlock)
    }
    
    func checkIsAssetLiked(id: String, completionBlock: @escaping (Bool) -> Void) {
        self.favouritesAssetsDataSource.checkIsAssetLiked(id: id, completionBlock: completionBlock)
    }
    
    func deleteAsset(id: String, completionBlock: @escaping (Bool) -> Void) {
        self.favouritesAssetsDataSource.deleteAsset(id: id, completionBlock: completionBlock)
    }
}
