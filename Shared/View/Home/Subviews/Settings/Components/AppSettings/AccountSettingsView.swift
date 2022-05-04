//
//  AccountSettingsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 03-05-22.
//

import SwiftUI

struct AccountSettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    
                    Text("Account Settings")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.white)
                
                
                Spacer()
                
                VStack {
                    Button {
                        //
                    } label: {
                        HStack {
                            Text("Email")
                                .font(.system(size: 14, design: .rounded))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, design: .rounded))
                        }
                        .padding(.vertical, 5)
                    }
                    
                    Divider()
                        .background(.gray)
                    
                    Button {
                        //
                    } label: {
                        HStack {
                            Text("Change Password")
                                .font(.system(size: 14, design: .rounded))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, design: .rounded))
                        }
                    }
                    .padding(.vertical, 5)

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
                .padding(.horizontal, 5)
                
                Spacer()
            }
            .padding(.horizontal, 5)
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

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
    }
}
