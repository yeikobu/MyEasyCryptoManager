//
//  DefaultLauchScreenViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-05-22.
//

import Foundation

final class DefaultLauchScreenViewModel: ObservableObject {
    @Published var selectedLaunchScreen: String?
    private let defaultLauchScreenRepository: DefaultLauchScreenRepository
    
    init(defaultLauchScreenRepository: DefaultLauchScreenRepository = DefaultLauchScreenRepository()) {
        self.defaultLauchScreenRepository = defaultLauchScreenRepository
    }
    
    /// This method sets an default screen when the app is open
    /// - Returns: ()
    func setDefaultLainchScreen(homescreen: String) {
        defaultLauchScreenRepository.setDefaultLainchScreen(homescreen: homescreen) { result in
            print(result)
        }
    }
    
    /// This method gets the name of the icon screen in order to be used to set the default open screen.
    /// - Returns: Void, but it uses a completion handler with a String escaping
    func getSelectedLaunchScreen(completionBlock: @escaping (String) -> Void) {
        self.defaultLauchScreenRepository.getSelectedLaunchScreen { result in
            switch result {
            case .success(let defaultScreenModel):
                completionBlock(defaultScreenModel.homescreen ?? "chart.bar.xaxis")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
