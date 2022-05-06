//
//  LaunchScreenSettingsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 03-05-22.
//

import SwiftUI

struct LaunchScreenSettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                VStack {
                    Text("Select your launch screen")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
                    VStack {
                        VStack {
                            Button {
                                //
                            } label: {
                                HStack {
                                    Text("Market")
                                        .font(.system(size: 14, design: .rounded))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.system(size: 14, design: .rounded))
                                }
                            }
                            
                            Divider()
                                .background(.gray)
                        }
                        
                        VStack {
                            Button {
                                //
                            } label: {
                                HStack {
                                    Text("Portfolio")
                                        .font(.system(size: 14, design: .rounded))
                                    
                                    Spacer()
                                    
                                    
                                }
                            }
                            
                        }
                        
                    }
                    .foregroundColor(.white)
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
            }
            .padding(.horizontal, 10)
            .padding(.top, 50)
            
            Button {
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
        .navigationBarBackButtonHidden(true)
    }
}

struct LaunchScreenSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenSettingsView()
    }
}
