//
//  MyEasyCryptoManagerApp.swift
//  Shared
//
//  Created by Jacob Aguilar on 07-03-22.
//

import SwiftUI

@main
struct MyEasyCryptoManagerApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .preferredColorScheme(.dark)
        }
    }
}
