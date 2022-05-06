//
//  DefaultLaunchScreenRepository.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-05-22.
//

import Foundation

final class DefaultLauchScreenRepository {
    private let defaultLaunchScreenDataSource: DefaultLaunchScreenDataSource
    
    init(defaultLaunchScreenDataSource: DefaultLaunchScreenDataSource = DefaultLaunchScreenDataSource()) {
        self.defaultLaunchScreenDataSource = defaultLaunchScreenDataSource
    }
    
    func setDefaultLainchScreen(homescreen: String, completionBlock: @escaping (Result<DefaultLaunchScreenModel, Error>) -> Void) {
        self.defaultLaunchScreenDataSource.setDefaultLainchScreen(homescreen: homescreen, completionBlock: completionBlock)
    }
}
