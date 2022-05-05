//
//  ChangeEmailView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 04-05-22.
//

import SwiftUI

struct ChangeEmailView: View {
    
    @ObservedObject var signupSigninValidation = SigninSignupValidation()
    @State var isSecure: Bool = true
    @State var showError: Bool = false
    @State var msgAlert: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @Binding var isButtonSelected: Bool
    let animation: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                VStack(alignment: .leading) {
                    
                    // MARK: - New email field
                    VStack(alignment: .leading) {
                        Text("Introduce your new email")
                            .matchedGeometryEffect(id: "email", in: animation)
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
                    .matchedGeometryEffect(id: "emailfield", in: animation)
                    
                    
                    // MARK: - Current password field
                    VStack(alignment: .leading) {
                        Text("Current Password")
                            .matchedGeometryEffect(id: "password", in: animation)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.bottom, -1)
                            .padding(.leading, 4)
                        
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .padding(.leading)
                            
                            ZStack(alignment: .leading) {
                                if signupSigninValidation.password.isEmpty {
                                    Text("Introduce your password")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                        .padding(.leading, 5)
                                }
                                
                                if isSecure {
                                    SecureField("", text: $signupSigninValidation.password)
                                        .foregroundColor(.white)
                                        .font(.body)
                                        .padding(15)
                                        .padding(.leading, -10)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                } else {
                                    TextField("", text: $signupSigninValidation.password)
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
                            
                            Button {
                                withAnimation(.spring()) {
                                    isSecure.toggle()
                                }
                                
                            } label: {
                                !isSecure ? Image(systemName: "eye")
                                    .opacity(0.5)
                                    .foregroundColor(Color(.red))
                                    .padding(.trailing) : Image(systemName: "eye.slash")
                                    .opacity(1)
                                    .foregroundColor(Color("Buttons"))
                                    .padding(.trailing)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .blur(radius: 0)
                                .opacity(0.7)
                        )
                    }
                    .matchedGeometryEffect(id: "passwordfield", in: animation)
                    
                    
                }
                .matchedGeometryEffect(id: "emailform", in: animation)
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
                
                //Signin Button
                Button {
                    //
                } label: {
                    Text("CHANGE EMAIL")
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
                .matchedGeometryEffect(id: "signinbutton", in: animation)
                .padding(.top, 240)
                .alert(isPresented: $showError) {
                    Alert(title: Text("ERROR"), message: Text("\(msgAlert)"), dismissButton: .default(Text("Okay")))
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    
    @Namespace static var animation
    
    static var previews: some View {
        ChangeEmailView(isButtonSelected: .constant(false), animation: animation)
    }
}
