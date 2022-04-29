//
//  FavouriteAssetViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 04-04-22.
//

import Foundation
import CloudKit
import SwiftUI

final class FavouriteAssetViewModel: ObservableObject {
    @Published var favouriteCoins: [FavouriteCoinModel] = []
    @Published var messageError: String?
    @Published var currentBalance: Double?
    @Published var assetsCount: Int?
    @Published var profitLoss: Double?
    @Published var profitLossPercentage: Double?
    private let favouriteAssetsRepository: FavouriteAssetsRepository
    private let specificCoinVM: SpecificCoinViewModel = SpecificCoinViewModel()
    
    init (favouriteAssetsRepository: FavouriteAssetsRepository = FavouriteAssetsRepository()) {
        self.favouriteAssetsRepository = favouriteAssetsRepository
    }
    
    @MainActor
    func getAllAssets() async {
        favouriteAssetsRepository.getAllAssets { [weak self] result in
            switch result {
            case .success(let favouriteCoinModel):
                self?.favouriteCoins = favouriteCoinModel
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
        
        for asset in self.favouriteCoins {
            var currentPrice: Double = 0
            var changepercentage: Double = 0
            
            do {
                currentPrice = try await specificCoinVM.getCurrentPrice(selectedCoin: asset.id ?? "")
                changepercentage = self.specificCoinVM.selectedSpecificCoinModel?.marketData?.priceChangePercentage24H ?? 0
            } catch {
                print(error)
            }
            
            self.updateAsset(id: asset.id ?? "", name: asset.name ?? "", symbol: asset.symbol ?? "", imgURL: asset.imgURL ?? "", purchasePrice: asset.purchasePrice ?? 0, purchaseQuantity: asset.purchaseQuantity ?? 0, currentPrice: currentPrice, priceChangePercentage24h: changepercentage)
        }
        
        
    }
    
    
    func addFavouriteAsset(id: String, name: String, symbol: String, imgURL: String, purchasePrice: Double, purchaseQuantity: Double, currentPrice: Double, priceChangePercentage24h: Double) {
        
        favouriteAssetsRepository.addFavouriteAsset(id: id, name: name, symbol: symbol, imgURL: imgURL, purchasePrice: purchasePrice, purchaseQuantity: purchaseQuantity, currentPrice: currentPrice, priceChangePercentage24h: priceChangePercentage24h) { result in
            switch result {
            case .success( _):
                print("Asset has been added to porfolio")
            case .failure(let error):
                self.messageError = error.localizedDescription
                print(error)
            }
        }
    }
    
    
    func updateAsset(id: String, name: String, symbol: String, imgURL: String, purchasePrice: Double, purchaseQuantity: Double, currentPrice: Double, priceChangePercentage24h: Double) {
        
        favouriteAssetsRepository.addFavouriteAsset(id: id, name: name, symbol: symbol, imgURL: imgURL, purchasePrice: purchasePrice, purchaseQuantity: purchaseQuantity, currentPrice: currentPrice, priceChangePercentage24h: priceChangePercentage24h) { result in
            switch result {
            case .success( _):
                print("Updating user asset information")
            case .failure(let error):
                self.messageError = error.localizedDescription
                print(error)
            }
        }
    }
    
    
    func calcCurrentBalance() async {
        var currentBalanceUSD: Double = 0
        var profitLossUSD: Double = 0
        
        favouriteAssetsRepository.getAllAssets { [weak self] result in
            switch result {
            case .success(let favouriteCoinModel):
                for asset in favouriteCoinModel {
                    currentBalanceUSD += (asset.currentPrice ?? 0) * (asset.purchaseQuantity ?? 0)
                    profitLossUSD += (asset.currentPrice ?? 0) - (asset.purchasePrice ?? 0)
                }
                self?.assetsCount = favouriteCoinModel.count
                self?.profitLoss = profitLossUSD
                self?.currentBalance = currentBalanceUSD
                self?.profitLossPercentage = (currentBalanceUSD * profitLossUSD) / 100
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    
    func checkIsAssetLiked(id: String, completionBlock: @escaping (Bool) -> Void) {
        favouriteAssetsRepository.checkIsAssetLiked(id: id) { result in
            completionBlock(result)
        }
    }
    
    
    func deleteAsset(id: String) {
        favouriteAssetsRepository.deleteAsset(id: id) { result in
            if result {
                print("\(id) removed!")
            }
        }
    }
    
}
