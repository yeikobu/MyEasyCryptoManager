//
//  SettingsModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 07-05-22.
//

import Foundation

struct SettingsModel {
    let twitterURL: String = "https://twitter.com/hide_attitude"
    let instagramURL: String = "https://www.instagram.com/dev.swift.jacob/"
    let githubURL: String = "https://github.com/J-kobu/"
    let linkedInURL: String = "https://www.linkedin.com/in/jacob-aguilar-campos/"
    let portfolioURL: String = "https://j-kobu.github.io/portfolio/"
    let termsAndService: String = "My Easy Crypto Manager app only uses the user email, which allows you to create a user account in Firebase Auth and synchronize your portfolio's data and your launch screen preference in Firebase Firestore Database, and in the case of forgetting the password, an email will be sent to your email address that will allow you to reset it. \n\nMy Easy Crypto Manager app doesn't read any private data from your device."
    
    let coinGeckoAPIText: String = "My Easy Crypto Manager uses the free Coin Gecko API to get each cryptocurrency information, and for this reason the calls to the API are limited to one minute."
    let glossary: [String : String] = [ : ]
}
