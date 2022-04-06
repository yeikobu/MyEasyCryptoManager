//
//  SpecificCoinViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-04-22.
//

import Foundation

final class SpecificCoinViewModel: ObservableObject {
    
    @Published var specificCoinModel: SpecificCoinModel?
    @Published var selectedCoin: String
    private let baseUrl: String = "https://api.coingecko.com/api/v3/coins/"
    
    
    init(selectedCoin: String) {
        self.selectedCoin = selectedCoin
        
        print("Selected coin: \(self.selectedCoin)")
        let finalURL = URL(string: baseUrl + selectedCoin)!
        print("Url final \(finalURL)")
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            do {
                if let jsonData = data {
                    let decodeData = try JSONDecoder().decode(SpecificCoinModel.self, from: jsonData)
                    print("")
                    print("Specific coin: \(decodeData)")
                    DispatchQueue.main.async {
                        self.specificCoinModel = decodeData
                    }
                }
            } catch {
                print("Specific coin error: \(error)")
            }
        }.resume()
    }
    
    
    func getCurrentPrice() {
        self.selectedCoin = selectedCoin
        print("Selected coin: \(selectedCoin)")
        print("Selected coin: \(self.selectedCoin)")
    }
}
