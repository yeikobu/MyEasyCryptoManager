//
//  DefaultLauchScreenViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-05-22.
//

import Foundation

final class DefaultLauchScreenViewModel: ObservableObject {
    @Published var selectedLaunchScreen: String = "chart.bar.xaxis"
    private let defaultLauchScreenRepository: DefaultLauchScreenRepository
    
    init(defaultLauchScreenRepository: DefaultLauchScreenRepository = DefaultLauchScreenRepository()) {
        self.defaultLauchScreenRepository = defaultLauchScreenRepository
    }
    
    func setDefaultLainchScreen(homescreen: String) {
        defaultLauchScreenRepository.setDefaultLainchScreen(homescreen: homescreen) { result in
            print(result)
        }
    }
}
