//
//  SettingsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 28-03-22.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var settingsViewModel = SettingsViewModel()
    @State var isLogoutActive: Bool = false
    @State var isButtonSelected: Bool = false
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .padding(.horizontal, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(showsIndicators: false) {
                
                // MARK: - App Settings
                VStack(alignment: .leading) {
                    Text("App")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .padding(.top)
                        .padding(.bottom, -4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        
                        Button {
                            self.isButtonSelected = true
                            self.settingsViewModel.appSettings = .accountSettings
                        } label: {
                            HStack {
                                Text("Account")
                                    .font(.system(size: 14, design: .rounded))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, design: .rounded))
                            }
                            .padding(.vertical, 5)
                        }
                        .foregroundColor(.white)
                        
                        Divider()
                            .background(.gray)
                        
                        Button {
                            self.isButtonSelected = true
                            self.settingsViewModel.appSettings = .defaultLaunchScreen
                        } label: {
                            HStack {
                                Text("Launch Screen")
                                    .font(.system(size: 14, design: .rounded))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, design: .rounded))
                            }
                            .padding(.vertical, 5)
                        }
                        .foregroundColor(.white)
                        
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
                }
                .padding(.horizontal, 5)
                
                // MARK: - About this app
                VStack(alignment: .leading) {
                    Text("About the app")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .padding(.top)
                        .padding(.bottom, -4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        
                        Button {
                            self.isButtonSelected = true
                            self.settingsViewModel.appSettings = .termsAndPrivacy
                        } label: {
                            HStack {
                                Text("Terms and Privacy")
                                    .font(.system(size: 14, design: .rounded))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, design: .rounded))
                            }
                            .padding(.vertical, 5)
                        }
                        .foregroundColor(.white)
                        
                        .onTapGesture {
                            //
                        }
                        
                        Divider()
                            .background(.gray)
                        
                        
                        HStack {
                            Text("Crypto Glossary")
                                .font(.system(size: 14, design: .rounded))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, design: .rounded))
                        }
                        .padding(.vertical, 5)
                        .onTapGesture {
                            //
                        }
                        
                        Divider()
                            .background(.gray)
                        
                        
                        Button {
                            self.isButtonSelected = true
                            self.settingsViewModel.appSettings = .donate
                        } label: {
                            HStack {
                                Text("Donate")
                                    .font(.system(size: 14, design: .rounded))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, design: .rounded))
                            }
                            .padding(.vertical, 5)
                        }
                        .foregroundColor(.white)
                        
                       
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .blur(radius: 0)
                            .opacity(0.8)
                    )
                }
                .padding(.horizontal, 5)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                
                // MARK: - Contact
                VStack(alignment: .leading) {
                    Text("Contact")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .padding(.top)
                        .padding(.bottom, -4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        
                        Button {
                            self.openURL(URL(string: self.settingsViewModel.settingsModel.twitterURL)!)
                        } label: {
                            HStack {
                                Image("twitter-fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 14, height: 14)
                                
                                Text("Follow me on Twitter")
                                    .font(.system(size: 14, design: .rounded))
                            }
                            .padding(.vertical, 5)
                        }
                        .foregroundColor(.white)
                        
                        Divider()
                            .background(.gray)
                        
                        
                        Button {
                            self.openURL(URL(string: self.settingsViewModel.settingsModel.instagramURL)!)
                        } label: {
                            HStack {
                                Image("instagram-fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 14, height: 14)
                                
                                Text("Follow me on Instagram")
                                    .font(.system(size: 14, design: .rounded))
                            }
                            .padding(.vertical, 5)
                        }
                        .foregroundColor(.white)
                        
                        Divider()
                            .background(.gray)
                        
                        Button {
                            self.openURL(URL(string: self.settingsViewModel.settingsModel.githubURL)!)
                        } label: {
                            HStack {
                                Image("github")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 14, height: 14)
                                
                                Text("Check my Github")
                                    .font(.system(size: 14, design: .rounded))
                            }
                            .padding(.vertical, 5)
                        }
                        .foregroundColor(.white)
                        
                        Divider()
                            .background(.gray)
                        
                        Button {
                            self.openURL(URL(string: self.settingsViewModel.settingsModel.linkedInURL)!)
                        } label: {
                            HStack {
                                Image("linkedin-fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 14, height: 14)
                                
                                Text("Contact me on LinkedIn")
                                    .font(.system(size: 14, design: .rounded))
                            }
                            .padding(.vertical, 5)
                        }
                        .foregroundColor(.white)
                       
                        Divider()
                            .background(.gray)
                        
                        Button {
                            self.openURL(URL(string: self.settingsViewModel.settingsModel.portfolioURL)!)
                        } label: {
                            HStack {
                                Image(systemName: "network")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 14, height: 14)
                                
                                Text("Check my development portfolio")
                                    .font(.system(size: 14, design: .rounded))
                            }
                            .padding(.vertical, 5)
                        }
                        .foregroundColor(.white)
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .blur(radius: 0)
                            .opacity(0.8)
                    )
                }
                .padding(.horizontal, 5)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                
                // MARK: - Log out button
                VStack {
                    Button {
                        AuthenticationViewModel().logout()
                        isLogoutActive = true
                    } label: {
                        VStack {
                            Text("Log Out")
                                .foregroundColor(.red)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                        }
                        .padding()
                        .frame(maxWidth: 250)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .blur(radius: 0)
                                .opacity(0.8)
                        )
                    }
                    .padding(.horizontal, 5)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                    .padding(.top, 20)
                    .padding(.bottom, 70)
                }
                
            }
            .cornerRadius(15)
            .padding(.horizontal, 5)
            .fullScreenCover(isPresented: $isButtonSelected) {
                switch self.settingsViewModel.appSettings {
                case .accountSettings:
                    AccountSettingsView()
                    
                case .defaultLaunchScreen:
                    LaunchScreenSettingsView()
                    
                case .defaultCurrency:
                    DefaultCurrencyView()
                    
                case .termsAndPrivacy:
                    TermsAndPrivacyView()
                    
                case .cryptoGlossary:
                    CryptoGlossaryView()
                    
                case .donate:
                    DonateView()
                }
            }
            
            NavigationLink(isActive: $isLogoutActive) {
                SigninSignupView()
            } label: {
                EmptyView()
            }
        
        }
        .preferredColorScheme(.dark)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
