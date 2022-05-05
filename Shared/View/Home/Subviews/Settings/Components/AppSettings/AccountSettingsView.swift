//
//  AccountSettingsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 03-05-22.
//

import SwiftUI

struct AccountSettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var isButtonSelected: Bool = false
    @State var accountSettings = SettingsModel.AccountSettings.email
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    
                    if !isButtonSelected {
                        Text("Account Settings")
                            .matchedGeometryEffect(id: "titles", in: animation)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            
                    } else {
                        Text("Change Email")
                            .matchedGeometryEffect(id: "title", in: animation)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.white)
                
                Spacer()
                
                if !self.isButtonSelected {
                    VStack {
                        VStack {
                            Button {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    self.isButtonSelected = true
                                }
                                
                                self.accountSettings = .email
                            } label: {
                                HStack {
                                    Text("Email")
//                                        .matchedGeometryEffect(id: "email", in: animation)
                                        .font(.system(size: 14, design: .rounded))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, design: .rounded))
                                }
                                .padding(.vertical, 5)
                            }
                            
                            Divider()
                                .background(.gray)
                                .matchedGeometryEffect(id: "signinbutton", in: animation)
                        }
                        .matchedGeometryEffect(id: "emailfield", in: animation)
                        
                        
                        VStack {
                            Button {
//                                self.isButtonSelected = true
//                                self.accountSettings = .password
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
                        .matchedGeometryEffect(id: "passwordfield", in: animation)
                        

                    }
                    .matchedGeometryEffect(id: "emailform", in: animation)
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
                   
                    
                }
                
                if self.isButtonSelected && self.accountSettings == .email {
                    ChangeEmailView(isButtonSelected: self.$isButtonSelected ,animation: animation)
                }
                
                Spacer()
                
                
                
            }
            .padding(.horizontal, 10)
            .padding(.top, 50)
            
            if !isButtonSelected {
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
                .matchedGeometryEffect(id: "xbutton", in: animation)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                .padding(.top, 50)
                .padding(.trailing, 10)
            } else {
                
                Button {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)){
                        self.isButtonSelected = false
                    }
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
                .matchedGeometryEffect(id: "xbutton", in: animation)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                .padding(.top, 300)
                .padding(.trailing, 10)
            }
           
         
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
