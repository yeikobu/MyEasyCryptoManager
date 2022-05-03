//
//  SpecificCoinViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-04-22.
//

import Foundation

final class SpecificCoinViewModel: ObservableObject {
    
    @Published var selectedSpecificCoinModel = SpecificCoinModel()
    @Published var selectedCoinCurrentPrice: Double?
    @Published var selectedCoinDescription: String?
    private let specificCoinRepository: SpecificCoinRepository
    
    init(specificCoinRepository: SpecificCoinRepository = SpecificCoinRepository()) {
        self.specificCoinRepository = specificCoinRepository
    }
    
    /// This method gets the current price when you pass the id of an asset.
    /// - Returns: Double
    @MainActor
    func getCurrentPrice(selectedCoin: String) async throws -> Double {
        self.selectedSpecificCoinModel = try await specificCoinRepository.getCurrentPrice(selectedCoin: selectedCoin)
        self.selectedCoinCurrentPrice = self.selectedSpecificCoinModel.marketData?.currentPrice["usd"] ?? 0
        
        return self.selectedSpecificCoinModel.marketData?.currentPrice["usd"] ?? 0
    }
    
    
    /// This method gets all the info about the asset, and also, deletes the html tags from the asset description.
    /// - Returns: ()
    func getSpecificCoin(selectedCoin: String) async {
        specificCoinRepository.getSpecificCoin(selectedCoin: selectedCoin) { result in
            switch result {
            case .success(let specificCoinModel):
                self.selectedSpecificCoinModel = specificCoinModel
//                print(self.selectedSpecificCoinModel?.marketData?.sparkline7D)
                if let selectedCoinCurrentPrice = specificCoinModel.marketData?.currentPrice["usd"] {
                    self.selectedCoinCurrentPrice = selectedCoinCurrentPrice
                }
                
                if let selectedCoinDescription = specificCoinModel.coinModelDescription?.en {
                    let range = NSRange(location: 0, length: selectedCoinDescription.count)
                    let regex = try! NSRegularExpression(pattern: "<.*?>", options: NSRegularExpression.Options.caseInsensitive)
                    let modString = regex.stringByReplacingMatches(in: selectedCoinDescription, options: [], range: range, withTemplate: "")
                    self.selectedCoinDescription = modString
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    /// This method gets a coin and returns the full model of the coin in order to be used instantly.
    /// - Returns: SpecificCoinModel
    @MainActor
    func getCoinAndReturnTheModel(selectedCoin: String) async throws -> SpecificCoinModel {
        let specificCoinModel = try await specificCoinRepository.getCurrentPrice(selectedCoin: selectedCoin)
        return specificCoinModel
    }
    
    
}
