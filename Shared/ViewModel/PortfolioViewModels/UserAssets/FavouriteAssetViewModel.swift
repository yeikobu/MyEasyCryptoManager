//
//  FavouriteAssetViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 04-04-22.
//

import Foundation

final class FavouriteAssetViewModel: ObservableObject {
    @Published var favouriteCoins: [FavouriteCoinModel] = []
    @Published var messageError: String?
    private let favouriteAssetsRepository: FavouriteAssetsRepository
    
    init (favouriteAssetsRepository: FavouriteAssetsRepository = FavouriteAssetsRepository()) {
        self.favouriteAssetsRepository = favouriteAssetsRepository
    }
    
    func getAllAssets() {
        favouriteAssetsRepository.getAllAssets { [weak self] result in
            switch result {
            case .success(let favouriteCoinModel):
                self?.favouriteCoins = favouriteCoinModel
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func addFavouriteAsset(id: String, name: String, symbol: String, imgURL: String, purchasePrice: Double, purchaseQuantity: Double, currentPrice: Double) {
        
        favouriteAssetsRepository.addFavouriteAsset(id: id, name: name, symbol: symbol, imgURL: imgURL, purchasePrice: purchasePrice, purchaseQuantity: purchaseQuantity) { result in
            switch result {
            case .success(_):
                print("Asset has been added to porfolio")
            case .failure(let error):
                self.messageError = error.localizedDescription
                print(error)
            }
        }
    }
}
