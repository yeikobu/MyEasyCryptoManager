//
//  ForgotPasswordView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 07-05-22.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @StateObject var authenticationViewModel: AuthenticationViewModel = AuthenticationViewModel()
    @ObservedObject var signupSigninValidation = SigninSignupValidation()
    @StateObject var haptics = Haptics()
    @State var email: String = ""
    @State var message: String = ""
    @State var showError: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("Reset Your Password")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.white)
                
                Spacer()
                
                ZStack {
                    VStack(alignment: .leading) {
                        Text("Introduce your email")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.bottom, -1)
                            .padding(.leading, 4)
                        
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .padding(.leading)
                            
                            ZStack(alignment: .leading) {
                                if signupSigninValidation.email.isEmpty {
                                    Text(verbatim: "example@example.com")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                        .padding(.leading, 5)
                                }
                                
                                TextField("", text: $signupSigninValidation.email)
                                    .foregroundColor(.white)
                                    .keyboardType(.emailAddress)
                                    .ignoresSafeArea(.keyboard, edges: .bottom)
                                    .font(.body)
                                    .padding(15)
                                    .padding(.leading, -10)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .blur(radius: 0)
                                .opacity(0.7)
                        )
                    }
                    .padding(10)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .blur(radius: 0)
                            .opacity(0.8)
                    )
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                    
                    Button {
                        if !signupSigninValidation.email.isEmpty &&  signupSigninValidation.email.contains("@") {
                            self.authenticationViewModel.forgotPass(email: signupSigninValidation.email) { message in
                                self.showError = true
                                self.message = message
                                self.signupSigninValidation.email = ""
                                self.haptics.dismissButtonPressed()
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            self.showError = true
                            self.message = "Email field must be completed correctly."
                        }
                    } label: {
                        Text("SEND EMAIL")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color("Buttons").opacity(0.95), Color("Buttons").opacity(0.9)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                            .padding(.horizontal, 30)
                            .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                            .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                    }
                    .padding(.top, 160)
                    .alert(isPresented: $showError) {
                        Alert(title: Text("Alert!"), message: Text(self.message), dismissButton: .default(Text("Okay")))
                    }

                }
                
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
        .navigationBarBackButtonHidden(true)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
