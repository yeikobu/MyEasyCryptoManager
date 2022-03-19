//
//  GlobalMarketViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 18-03-22.
//

import Foundation

final class GlobalMarketViewModel: ObservableObject {
    
    @Published var globalMarketModel: GlobalMarketModel?
    
    init() {
        let url = URL(string: "https://api.coingecko.com/api/v3/global")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if let jsonData = data {
                    let decodeData = try JSONDecoder().decode(GlobalMarketModel.self, from: jsonData)
                    print("Global market data")
                    print(decodeData)
                    DispatchQueue.main.async {
                        self.globalMarketModel = decodeData
                    }
                }

            } catch {
                print(error)
            }
        }.resume()
    }
    
}
