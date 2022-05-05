//
//  SettingsModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 03-05-22.
//

import Foundation

struct SettingsModel {
    
    enum AppSettings {
        case accountSettings
        case defaultLaunchScreen
        case defaultCurrency
        case termsOfService
        case privacyPolice
        case cryptoGlossary
    }
    
    enum AccountSettings {
        case email
        case password
    }
    
//    enum AboutTheApp {
//        case termsOfService
//        case privacyPolice
//        case cryptoGlossary
//    }
}
