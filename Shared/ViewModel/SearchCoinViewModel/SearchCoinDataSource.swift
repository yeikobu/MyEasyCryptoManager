//
//  SearchCoinViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 26-04-22.
//

import Foundation

final class SearchCoinDataSource {
    
    private var searchCoinModel: SearchCoinModel?
    private let baseURL: String = "https://api.coingecko.com/api/v3/search?query="
    
    func getCoins(searchedCoin: String, completionBlock: @escaping (Result<SearchCoinModel, Error>) -> Void) {
        let finalURL = URL(string: baseURL + searchedCoin)!
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            do {
                if let jsonData = data {
                    let decodeData = try JSONDecoder().decode(SearchCoinModel.self, from: jsonData)
                    DispatchQueue.main.async {
                        self.searchCoinModel = decodeData
                        completionBlock(.success(decodeData))
                    }
                }
            } catch {
                print("Error: \(error)")
                completionBlock(.failure(error))
            }
        }.resume()
    }
}
