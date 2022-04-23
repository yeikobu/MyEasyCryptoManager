//
//  SpecificCoinViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-04-22.
//

import Foundation

final class SpecificCoinViewModel: ObservableObject {
    
    @Published var selectedSpecificCoinModel: SpecificCoinModel?
    @Published var currentPrice: [String : Double] = [ : ]
    @Published var selectedCoinCurrentPrice: Double?
    @Published var selectedCoinDescription: String?
    private let specificCoinRepository: SpecificCoinRepository
    
    init(specificCoinRepository: SpecificCoinRepository = SpecificCoinRepository()) {
        self.specificCoinRepository = specificCoinRepository
    }
    
    @MainActor
    func getCurrentPrice(selectedCoin: String) async throws {
        self.selectedSpecificCoinModel = try await specificCoinRepository.getCurrentPrice(selectedCoin: selectedCoin)
        self.selectedCoinCurrentPrice = self.selectedSpecificCoinModel?.marketData?.currentPrice["usd"] ?? 0
        self.currentPrice[selectedCoin] = self.selectedSpecificCoinModel?.marketData?.currentPrice["usd"] ?? 0
    }
    
    
    func getSpecificCoin(selectedCoin: String) async {
        specificCoinRepository.getSpecificCoin(selectedCoin: selectedCoin) { result in
            switch result {
            case .success(let specificCoinModel):
                self.selectedSpecificCoinModel = specificCoinModel
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
    
}
