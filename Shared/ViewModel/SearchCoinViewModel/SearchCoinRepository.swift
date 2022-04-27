//
//  SearchCoinRepository.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 26-04-22.
//

import Foundation

final class SearchCoinRepository {
    private let searchCoinDataSource: SearchCoinDataSource
    
    init(searchCoinDataSource: SearchCoinDataSource = SearchCoinDataSource()) {
        self.searchCoinDataSource = searchCoinDataSource
    }
    
    func getCoins(searchCoin: String, completionBlock: @escaping (Result<SearchCoinModel, Error>) -> Void) {
        self.searchCoinDataSource.getCoins(searchedCoin: searchCoin, completionBlock: completionBlock)
    }
}
