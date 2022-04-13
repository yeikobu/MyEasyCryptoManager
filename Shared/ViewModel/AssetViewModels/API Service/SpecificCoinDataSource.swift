//
//  SpecificCoinDataSource.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 06-04-22.
//

import Foundation

final class SpecificCoinDataSource {
    
    private var specificCoinModel: SpecificCoinModel?
    private let baseUrl: String = "https://api.coingecko.com/api/v3/coins/"
    
    func getSpecificCoin(selectedCoin: String, completionBlock: @escaping (Result<[SpecificCoinModel], Error>) -> Void) {
        let finalURL = URL(string: baseUrl + selectedCoin)!
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            do {
                if let jsonData = data {
                    let decodeData = try JSONDecoder().decode(SpecificCoinModel.self, from: jsonData)
                    print("")
//                    print("Specific coin: \(decodeData)")
                    DispatchQueue.main.async {
                        self.specificCoinModel = decodeData
                        completionBlock(.success([decodeData]))
                    }
                }
            } catch {
                print("Specific coin error: \(error)")
                completionBlock(.failure(error))
            }
            
            
        }.resume()
    }
}
