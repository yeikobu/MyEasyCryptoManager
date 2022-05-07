//
//  SettingsViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 03-05-22.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    
    @Published var appSettings = AppSettings.accountSettings
    @Published var accountSettings = AccountSettings.email
    
    enum AppSettings {
        case accountSettings
        case defaultLaunchScreen
        case defaultCurrency
        case termsOfService
        case privacyPolice
        case cryptoGlossary
        case donate
    }
    
    enum AccountSettings {
        case email
        case password
    }
}
