//
//  AccountSettingsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 03-05-22.
//

import SwiftUI

struct AccountSettingsView: View {
    
    @StateObject var authenticationViewModel: AuthenticationViewModel = AuthenticationViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var haptics = Haptics()
    @Environment(\.presentationMode) var presentationMode
    @State var isButtonSelected: Bool = false
    @State var isChangePasswordButtonSelected: Bool = false
    @State var message: String = ""
    @State var email: String = ""
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    
                    //If isButtonSelected is false shows in the title Account Settings, else Change Email
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
                
                //If isButtonSelected is false shows AccountSettingsView else
                if !self.isButtonSelected {
                    VStack {
                        VStack {
                            Button {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    self.isButtonSelected = true
                                }
                                
                                self.settingsViewModel.accountSettings = .email
                            } label: {
                                HStack {
                                    Text("Email")
                                        .font(.system(size: 14, design: .rounded))
                                    
                                    Spacer()
                                    
                                    Text(authenticationViewModel.user?.email ?? self.email)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 12, design: .rounded))
                                    
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
                                authenticationViewModel.recoverPass { resultMessage in
                                    self.message = resultMessage
                                }
                                self.isChangePasswordButtonSelected = true
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
                    .alert(isPresented: $isChangePasswordButtonSelected) {
                        Alert(title: Text("ALERT!"), message: Text("\(self.message)"), dismissButton: .default(Text("Okay")))
                    }
                   
                    
                }
                
                //If isButtonSelected is true and the selected option from the enum is email, it will show ChangeEmailView
                if self.isButtonSelected && self.settingsViewModel.accountSettings == .email {
                    ChangeEmailView(email: $email, isButtonSelected: self.$isButtonSelected ,animation: animation)
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 50)
            
            
            //If isButtonSelected is false shows the X button close to the view title
            if !isButtonSelected {
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
                .matchedGeometryEffect(id: "xbutton", in: animation)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                .padding(.top, 50)
                .padding(.trailing, 10)
                
            //Else show the X button close to the ChangeEmailView
            } else {
                
                Button {
                    self.haptics.dismissButtonPressed()
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)){
                        self.isButtonSelected = false
                    }
                    
                    authenticationViewModel.getCurrentUser()
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
                .padding(.top, 350)
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
