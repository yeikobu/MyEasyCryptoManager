//
//  SpecificCoinRepository.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 06-04-22.
//

import Foundation

final class SpecificCoinRepository {
    private let specificCoinDataSource: SpecificCoinDataSource
    
    init(specificCoinDataSource: SpecificCoinDataSource = SpecificCoinDataSource()) {
        self.specificCoinDataSource = specificCoinDataSource
    }
    
    func getSpecificCoin(selectedCoin: String, completionBlock: @escaping (Result<[SpecificCoinModel], Error>) -> Void) {
        self.specificCoinDataSource.getSpecificCoin(selectedCoin: selectedCoin, completionBlock: completionBlock)
    }
}
