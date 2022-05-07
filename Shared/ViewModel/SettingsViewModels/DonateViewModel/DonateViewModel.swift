//
//  DonateViewModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 06-05-22.
//

import Foundation
import SwiftUI

final class DonateViewModel: ObservableObject {
    
    @Published var donateModel = DonateModel()
    private let pasteboard = UIPasteboard.general
    
    /// This method copies the wallet direction to clipboard in order to be pasted wherever outside of the app.
    /// - Returns: ()
    func copyToClipboard() {
        pasteboard.string = donateModel.walletDirection
    }
}
