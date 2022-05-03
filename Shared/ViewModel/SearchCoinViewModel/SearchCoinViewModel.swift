//
//  File.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 26-04-22.
//

import Foundation

final class SearchCoinViewModel: ObservableObject {
    
    @Published var searchCoinModel: SearchCoinModel?
    private let searchCoinRepository: SearchCoinRepository
    
    init(searchCoinRepository: SearchCoinRepository = SearchCoinRepository()) {
        self.searchCoinRepository = searchCoinRepository
    }
    
    
    /// This method gets the most basic data about a coin when it is searched in a view.
    /// - Returns: ()
    func getCoins(searchedCoin: String)  {
        searchCoinRepository.getCoins(searchCoin: searchedCoin) { result in
            switch result {
            case .success(let searchedCoins):
                self.searchCoinModel = searchedCoins
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
