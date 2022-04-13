//
//  SpecificCoinViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-04-22.
//

import Foundation

final class SpecificCoinViewModel: ObservableObject {
    
    @Published var specificCoinModel: [SpecificCoinModel] = []
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
    
//    func getCurrentPrice(selectedCoin: String) {
//        self.selectedCoin = selectedCoin
//        var actualPrice: Double = 0
//
//        let finalURL = URL(string: baseUrl + selectedCoin)!
//
//        URLSession.shared.dataTask(with: finalURL) { data, response, error in
//            do {
//                if let jsonData = data {
//                    let decodeData = try JSONDecoder().decode(SpecificCoinModel.self, from: jsonData)
//                    print("")
//                    print("Specific coin: \(decodeData)")
//                    DispatchQueue.main.async {
//                        self.specificCoinModel = decodeData
//                        if let currentprice = self.specificCoinModel?.marketData?.currentPrice["usd"] {
//                            actualPrice = currentprice
//                            print("Current price \(self.currentPrice)")
//                        }
//                    }
//                }
//            } catch {
//                print("Specific coin error: \(error)")
//            }
//        }.resume()
//
//        print(actualPrice)
//        return actualPrice
//    }
}
