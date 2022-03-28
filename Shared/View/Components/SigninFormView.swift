//
//  SigninFormView.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 27-03-22.
//

import SwiftUI
import FirebaseAuth

struct SigninFormView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var signupSigninValidation = SigninSignupValidation()
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isSecure: Bool = true
    @State var isUserForgotPass: Bool = false
    @Binding var isSigninActive: Bool
    @Namespace var animation
    
    @State var showError: Bool = false
    @State var msgAlert: String = ""
    @State var areSingInfieldsComplete: Bool = false
    @State var isUserNotFound = false
    
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
                                if signupSigninValidation.email.isEmpty {
                                    Text(verbatim: "example@example.com")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                        .padding(.leading, 5)
                                }
                                
                                TextField("", text: $signupSigninValidation.email)
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
                        .matchedGeometryEffect(id: "passwordfield", in: animation)
                        
                        //Forgot Pass
                        VStack(alignment: .trailing) {
                            Button {
                                isUserForgotPass = true
                            } label: {
                                Text("Forgot password?")
                                    .foregroundColor(Color("Buttons"))
                                    .opacity(1)
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                    .shadow(color: .black.opacity(0.6), radius: 1, x: 1, y: 1)
                                    .shadow(color: .black.opacity(0.6), radius: 1, x: -1, y: -1)
                            }
                        }
                        .matchedGeometryEffect(id: "forgotpass", in: animation)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, 20)
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
                .matchedGeometryEffect(id: "signinform", in: animation)
                .offset(x: isSigninActive ? 0 : 0, y: isSigninActive ? 0 : 1400)
                .padding(.horizontal, 10)
                .frame(maxHeight: .infinity)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                
                //Signin Button
                Button {
                    signin()
                } label: {
                    Text("SIGN IN")
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
                .matchedGeometryEffect(id: "signinbutton", in: animation)
                .offset(x: isSigninActive ? 0 : 0, y: isSigninActive ? 0 : 1000)
                .padding(.top, 280)
                .alert(isPresented: $showError) {
                    Alert(title: Text("ERROR"), message: Text("\(msgAlert)"), dismissButton: .default(Text("Okay")))
                }
            }
            
            NavigationLink(isActive: $areSingInfieldsComplete) {
                DashboardView()
            } label: {
                EmptyView()
            }
        }
        .onAppear {
            autoSignin()
        }
    }
    
    func autoSignin() {
        if authenticationViewModel.user != nil {
            self.isUserNotFound = false
            self.areSingInfieldsComplete = true
        }
    }
    
    func signin() {
        if (signupSigninValidation.email.isEmpty || signupSigninValidation.password.isEmpty) {
            self.areSingInfieldsComplete = false
            self.isUserNotFound = true
            self.showError = true
            self.msgAlert = "Fields can not be empty!"
        } else if let error = authenticationViewModel.errorMessage {
            if error.isEmpty {
                areSingInfieldsComplete = true
            } else {
                self.msgAlert = "Email or Password not found"
                self.showError = true
            }
        } else {
            authenticationViewModel.signin(email: signupSigninValidation.email, password: signupSigninValidation.password)
            self.areSingInfieldsComplete = true
        }
        
    }
}

struct SigninFormView_Previews: PreviewProvider {
    
    @Namespace static var animation
    
    static var previews: some View {
        SigninFormView(authenticationViewModel: AuthenticationViewModel(), isSigninActive: .constant(false))
            .preferredColorScheme(.dark)
    }
}
