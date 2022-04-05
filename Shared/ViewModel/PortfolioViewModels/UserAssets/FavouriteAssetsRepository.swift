//
//  FavouriteAssetsRepository.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 04-04-22.
//

import Foundation

final class FavouriteAssetsRepository {
    private let favouritesAssetsDataSource: FavouriteAssetsDataSource
    
    init(favouritesAssetsDataSource: FavouriteAssetsDataSource = FavouriteAssetsDataSource()) {
        self.favouritesAssetsDataSource = favouritesAssetsDataSource
    }
    
    func getAllAssets(completionBlock: @escaping (Result<[FavouriteCoinModel], Error>) -> Void) {
        self.favouritesAssetsDataSource.getAllAssets(completionBlock: completionBlock)
    }
}
