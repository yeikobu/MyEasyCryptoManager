//
//  DefaultLaunchScreenDataSource.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-05-22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

final class DefaultLaunchScreenDataSource {
    private let database = Firestore.firestore()
    private let collection = "Users"
    private let uid = String(describing: Auth.auth().currentUser?.uid)
    private let subCollection = "LaunchScreen"
    private let id = "homescreen"
    
    func setDefaultLainchScreen(homescreen: String, completionBlock: @escaping (Result<DefaultLaunchScreenModel, Error>) -> Void) {
        let homeScreen = DefaultLaunchScreenModel(homescreen: homescreen)
        
        do {
            try database.collection(collection).document(uid).collection(subCollection).document(id).setData(from: homeScreen)
            
            completionBlock(.success(homeScreen))
        } catch {
            completionBlock(.failure(error))
        }
    }
    
    
    func getSelectedLaunchScreen(completionBlock: @escaping (Result<DefaultLaunchScreenModel, Error>) -> Void) {
        database.collection(collection).document(uid).collection(subCollection).getDocuments { query, error in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                guard let documents = query?.documents.compactMap({$0}) else {
                    return
                }
                
                let documentsArray = documents
                    .map { try? $0.data(as: DefaultLaunchScreenModel.self) }
                    .compactMap { $0 }
                
                for selectedDefaultScreen in documentsArray {
                    completionBlock(.success(selectedDefaultScreen))
                }
            }
        }
    }
    
}


