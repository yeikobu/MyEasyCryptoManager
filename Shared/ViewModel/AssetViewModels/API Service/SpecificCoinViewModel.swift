//
//  SpecificCoinViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-04-22.
//

import Foundation

final class SpecificCoinViewModel: ObservableObject {
    
    @Published var specificCoinModel: [SpecificCoinModel] = []
    @Published var selectedSpecificCoinModel: [SpecificCoinModel]?
    @Published var selectedCoin: String?
    @Published var currentPrice: Double?
    private let specificCoinRepository: SpecificCoinRepository
    
    
    init(specificCoinRepository: SpecificCoinRepository = SpecificCoinRepository()) {
        self.specificCoinRepository = specificCoinRepository
    }
    
    
    func getSpecificCoin(selectedCoin: String) {
        specificCoinRepository.getSpecificCoin(selectedCoin: selectedCoin) { [weak self] result in
            switch result {
                
            case .success(let specificCoinModel):
                print("Vm specific coin model: \(specificCoinModel)")
                self?.selectedSpecificCoinModel = specificCoinModel
                self?.specificCoinModel = specificCoinModel
                self?.specificCoinModel.forEach({ item in
                    if let currentPrice = item.marketData?.currentPrice["usd"] {
                        self?.currentPrice = currentPrice
                        print("VM current price \(String(describing: self?.currentPrice))")
                        print("Closure current price \(currentPrice)")
                    } else {
                        print("error")
                    }
                })
                
            case .failure(let error):
                print(error)
            }
        }
    }

    
}
