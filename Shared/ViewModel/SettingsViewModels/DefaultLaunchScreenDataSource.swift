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
        let homeScreen = DefaultLaunchScreenModel(launchScreen: homescreen)
        
        do {
            try database.collection(collection).document(uid).collection(subCollection).document(id).setData(from: homescreen)
            
            completionBlock(.success(homeScreen))
        } catch {
            completionBlock(.failure(error))
        }
    }

}


