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
            
            print(assets)
            print("Data source")
            completionBlock(.success(assets))
        }
    }
}
