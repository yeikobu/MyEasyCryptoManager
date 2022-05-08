//
//  TermsOfServiceView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 04-05-22.
//

import SwiftUI

struct TermsAndPrivacyView: View {
    
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var haptics = Haptics()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("Terms and Privacy")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("\(settingsViewModel.settingsModel.termsAndService)")
                        .foregroundColor(.white)
                        .font(.system(size: 13, design: .rounded))
                    
                    Text("\n\(settingsViewModel.settingsModel.coinGeckoAPIText)")
                        .foregroundColor(.white)
                        .font(.system(size: 13, design: .rounded))
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .blur(radius: 0)
                        .opacity(0.8)
                )
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 50)
            
            Button {
                self.haptics.dismissButtonPressed()
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .padding(6)
                    .foregroundColor(Color("Buttons"))
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                            .blur(radius: 0)
                            .opacity(0.8)
                    )
            }
            .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
            .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
            .padding(.top, 50)
            .padding(.trailing, 10)
            
        }
        .ignoresSafeArea()
        .frame(maxHeight: .infinity)
        .background(
            Image("wallpaper2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.4)
        )
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
    }
}

struct TermsAndPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndPrivacyView()
    }
}
