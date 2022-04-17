//
//  FavouriteAssetsDataSource.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 04-04-22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


final class FavouriteAssetsDataSource {
    private let database = Firestore.firestore()
    private let collection = "FavouriteAssets"
    private let uid = String(describing: Auth.auth().currentUser!.uid)
    private let subCollection = "asset"
    
    func getAllAssets(completionBlock: @escaping (Result<[FavouriteCoinModel], Error>) -> Void) {
        database.collection(collection).document(uid).collection(subCollection).addSnapshotListener { query, error in
            if let error = error {
                print("Error: \(error)")
                completionBlock(.failure(error))
                return
            }
            
            guard let documents = query?.documents.compactMap({$0}) else {
                completionBlock(.success([]))
                return
            }
            
            let assets = documents
                .map { try? $0.data(as: FavouriteCoinModel.self) }
                .compactMap { $0 }
            
            completionBlock(.success(assets))
        }
    }
    
    func addFavouriteAsset(id: String, name: String, symbol: String, imgURL: String, purchasePrice: Double, purchaseQuantity: Double, completionBlock: @escaping (Result<FavouriteCoinModel, Error>) -> Void) {
        let favouriteAsset = FavouriteCoinModel(id: id, name: name, symbol: symbol, imgURL: imgURL, purchasePrice: purchasePrice, purchaseQuantity: purchaseQuantity)
        
        do {
            try database.collection(collection).document(uid).collection(subCollection).document(String(id)).setData(from: favouriteAsset)
            
            completionBlock(.success(favouriteAsset))
        } catch {
            completionBlock(.failure(error))
        }
    }
}