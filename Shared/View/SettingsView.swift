//
//  SettingsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 28-03-22.
//

import SwiftUI

struct SettingsView: View {
    
    @State var isLogoutActive: Bool = false
    
    var body: some View {
        VStack {
            Button {
                AuthenticationViewModel().logout()
                isLogoutActive = true
            } label: {
                VStack {
                    Text("Logout")
                        .foregroundColor(.red)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .blur(radius: 0)
                        .opacity(0.8)
                )
            }
            .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
            .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
            
            NavigationLink(isActive: $isLogoutActive) {
                SigninSignupView()
            } label: {
                EmptyView()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
