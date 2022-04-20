//
//  SpecificCoinViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-04-22.
//

import Foundation

final class SpecificCoinViewModel: ObservableObject {
    
    @Published var specificCoinModel: [SpecificCoinModel] = []
    @Published var selectedSpecificCoinModel: SpecificCoinModel?
    @Published var selectedCoin: String?
    @Published var currentPrice: Double?
    @Published var selectedCoinCurrentPrice: Double?
//    @Published var selectedCoinDescription: NSAttributedString?
    @Published var selectedCoinDescription: String?
    private let specificCoinRepository: SpecificCoinRepository
    
    
    init(specificCoinRepository: SpecificCoinRepository = SpecificCoinRepository()) {
        self.specificCoinRepository = specificCoinRepository
    }
    
    
    func getAllSpecificCoins(selectedCoin: String) {
        specificCoinRepository.getAllSpecificCoins(selectedCoin: selectedCoin) { [weak self] result in
            
            switch result {
            case .success(let specificCoinModel):
                self?.specificCoinModel = specificCoinModel
                self?.specificCoinModel.forEach({ item in
                    if let currentPrice = item.marketData?.currentPrice["usd"] {
                        self?.currentPrice = currentPrice
                    } else {
                        print("error")
                    }
                })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getSpecificCoin(selectedCoin: String) {
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
