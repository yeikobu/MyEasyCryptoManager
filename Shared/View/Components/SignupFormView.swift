//
//  SignupFormView.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 27-03-22.
//

import SwiftUI

struct SignupFormView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isSecure: Bool = true
    @State var isConfirmPassSecure: Bool = true
    @State var isUserForgotPass: Bool = false
    @Binding var isSigninActive: Bool
    @Namespace var animation
    
    var body: some View {
        VStack {
            ZStack {
                ZStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Email")
                            .matchedGeometryEffect(id: "email", in: animation)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.bottom, -1)
                            .padding(.leading, 4)
                        
                        //Email field
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .padding(.leading)
                            
                            ZStack(alignment: .leading) {
                                if email.isEmpty {
                                    Text(verbatim: "example@example.com")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                        .padding(.leading, 5)
                                }
                                
                                TextField("", text: $email)
                                    .foregroundColor(.white)
                                    .keyboardType(.emailAddress)
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
                        .matchedGeometryEffect(id: "emailfield", in: animation)
                        
                        Text("Password")
                            .matchedGeometryEffect(id: "password", in: animation)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.bottom, -1)
                            .padding(.leading, 4)
                        
                        //Password field
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .padding(.leading)
                            
                            ZStack(alignment: .leading) {
                                if password.isEmpty {
                                    Text("Must be content with at least 6 characters")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                        .padding(.leading, 5)
                                }
                                
                                if isSecure {
                                    SecureField("", text: $password)
                                        .foregroundColor(.white)
                                        .font(.body)
                                        .padding(15)
                                        .padding(.leading, -10)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                } else {
                                    TextField("", text: $password)
                                        .foregroundColor(.white)
                                        .keyboardType(.emailAddress)
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
                                    .opacity(0.5)
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
                        .matchedGeometryEffect(id: "passwordfield", in: animation)
                        
                        Text("Confirm password")
                            .matchedGeometryEffect(id: "comfirmpass", in: animation)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.bottom, -1)
                            .padding(.leading, 4)
                        
                        //Password field
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .padding(.leading)
                            
                            ZStack(alignment: .leading) {
                                if confirmPassword.isEmpty {
                                    Text("Confirm your password")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                        .padding(.leading, 5)
                                }
                                
                                if isConfirmPassSecure {
                                    SecureField("", text: $confirmPassword)
                                        .foregroundColor(.white)
                                        .font(.body)
                                        .padding(15)
                                        .padding(.leading, -10)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                } else {
                                    TextField("", text: $confirmPassword)
                                        .foregroundColor(.white)
                                        .keyboardType(.emailAddress)
                                        .font(.body)
                                        .padding(15)
                                        .padding(.leading, -10)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button {
                                withAnimation(.spring()) {
                                    isConfirmPassSecure.toggle()
                                }
                                
                            } label: {
                                !isConfirmPassSecure ? Image(systemName: "eye")
                                    .opacity(0.5)
                                    .foregroundColor(Color(.red))
                                    .padding(.trailing) : Image(systemName: "eye.slash")
                                    .opacity(0.5)
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
                        .matchedGeometryEffect(id: "comfirmpassfield", in: animation)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 40)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .blur(radius: 0)
                        .opacity(0.85)
                )
                .matchedGeometryEffect(id: "signupform", in: animation)
                .offset(x: isSigninActive ? 0 : 0, y: isSigninActive ? 1400 : 0)
                .padding(.horizontal, 10)
                .frame(maxHeight: .infinity)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                
                Button {
                    //
                } label: {
                    Text("SIGN UP")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color("Buttons").opacity(0.85), Color("Buttons").opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(15)
                        .padding(.horizontal, 30)
                        .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                        .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                }
                .matchedGeometryEffect(id: "signupbutton", in: animation)
                .offset(x: isSigninActive ? 0 : 0, y: isSigninActive ? 1000 : 0)
                .padding(.top, 320)
            }
        }
    }
}

struct SignupFormView_Previews: PreviewProvider {
    static var previews: some View {
        SignupFormView(isSigninActive: .constant(false))
            .preferredColorScheme(.dark)
    }
}
