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
    @Published var favouriteCoins: [FavouriteCoinModel] = [].uniqued()
    @Published var messageError: String?
    @Published var currentBalance: Double?
    @Published var assetsCount: Int?
    @Published var profitLoss: Double?
    @Published var profitLossPercentage: Double?
    private let favouriteAssetsRepository: FavouriteAssetsRepository
    private let specificCoinVM: SpecificCoinViewModel = SpecificCoinViewModel()
    
    init (favouriteAssetsRepository: FavouriteAssetsRepository = FavouriteAssetsRepository()) {
        self.favouriteAssetsRepository = favouriteAssetsRepository
        
        Task {
            await getAllAssets()
        }
        
    }
    
    /// This method gets all the user assets from the database previously added to the portfolio.
    /// Also, calculate the balance depending on the user holding coins.
    /// - Returns: ()
    @MainActor
    func getAllAssets() async {
        favouriteAssetsRepository.getAllAssets { [weak self] result in
            switch result {
            case .success(let favouriteCoinModel):
                self?.favouriteCoins = favouriteCoinModel
                self?.calcCurrentBalance()
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
        
        for asset in self.favouriteCoins {
            var currentPrice: Double = 0
            var changepercentage: Double = 0
            
            do {
                currentPrice = try await specificCoinVM.getCurrentPrice(selectedCoin: asset.id ?? "")
                changepercentage = self.specificCoinVM.selectedSpecificCoinModel.marketData?.priceChangePercentage24H ?? 0
            } catch {
                print(error)
            }
            
            self.updateAsset(id: asset.id ?? "", name: asset.name ?? "", symbol: asset.symbol ?? "", imgURL: asset.imgURL ?? "", purchasePrice: asset.purchasePrice ?? 0, purchaseQuantity: asset.purchaseQuantity ?? 0, currentPrice: currentPrice, priceChangePercentage24h: changepercentage)
        }

    }
    
    
    /// This method adds a coin to the portfolio and adds to database
    /// - Returns: ()
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
    
    
    /// This method just updates the coin data, and it adds to the database.
    /// - Returns: ()
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
    
    
    /// This method calculates the current balance, the profit/loss and the percentage of profit/loss.
    /// - Returns: ()
    func calcCurrentBalance() {
        var currentBalanceUSD: Double = 0
        var profitLossUSD: Double = 0
        var investedUSD: Double = 0
        
        favouriteAssetsRepository.getAllAssets { [weak self] result in
            switch result {
            case .success(let favouriteCoinModel):
                for asset in favouriteCoinModel {
                    if (asset.purchaseQuantity ?? 0) > 0 && (asset.purchasePrice ?? 0) > 0 {
                        investedUSD += (asset.purchasePrice ?? 0) * (asset.purchaseQuantity ?? 0)
                        currentBalanceUSD += (asset.currentPrice ?? 0) * (asset.purchaseQuantity ?? 0)
                    }
                }
                
                if investedUSD > 0 {
                    profitLossUSD += currentBalanceUSD - investedUSD
                    self?.assetsCount = favouriteCoinModel.count
                    self?.profitLoss = profitLossUSD
                    self?.currentBalance = currentBalanceUSD
                    self?.profitLossPercentage = ((currentBalanceUSD - investedUSD) / investedUSD) * 100
                }
                
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    
    /// This method checks if an asset was previously added to the portfolio.
    /// - Returns: Void, but it uses a completion handler a Bool escaping.
    func checkIsAssetLiked(id: String, completionBlock: @escaping (Bool) -> Void) {
        favouriteAssetsRepository.checkIsAssetLiked(id: id) { result in
            completionBlock(result)
        }
    }
    
    
    /// This method deletes an asset from the portfolio.
    /// - Returns: ()
    func deleteAsset(id: String) {
        favouriteAssetsRepository.deleteAsset(id: id) { result in
            if result {
                print("\(id) removed!")
            }
        }
    }
    
}
