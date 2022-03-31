//
//  CoinInfoViewModel.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 17-03-22.
//

import Foundation


final class CoinInfoViewModel: ObservableObject {
    
    @Published var coinModel = [CoinsModel]()
    
    init() {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if let jsonData = data {
                    let decodeData = try JSONDecoder().decode([CoinsModel].self, from: jsonData)
                    DispatchQueue.main.async {
                        self.coinModel = decodeData
                    }
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
    func updateInfo() {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if let jsonData = data {
                    let decodeData = try JSONDecoder().decode([CoinsModel].self, from: jsonData)
                    print("Updating...")
                    DispatchQueue.main.async {
                        self.coinModel = decodeData
                    }
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
