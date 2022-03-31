//
//  SignupFormView.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 27-03-22.
//

import SwiftUI

struct SignupFormView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var signupSigninValidation = SigninSignupValidation()
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isSecure: Bool = true
    @State var isConfirmPassSecure: Bool = true
    @State var isUserForgotPass: Bool = false
    @Binding var isSigninActive: Bool
    @Namespace var animation
    
    @State var areFieldsComplete: Bool = false
    @State var areFieldsIncomplete: Bool = false
    @State var msgError: String = "Este mensaje para probar"
    
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
                            Image(systemName: "lock.slash")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .padding(.leading)
                            
                            ZStack(alignment: .leading) {
                                if signupSigninValidation.password.isEmpty {
                                    Text("At least 6 characters and 1 capital letter")
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
                            Image(systemName: "lock")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .padding(.leading)
                            
                            ZStack(alignment: .leading) {
                                if signupSigninValidation.confirmPassword.isEmpty {
                                    Text("Confirm your password")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                        .padding(.leading, 5)
                                }
                                
                                if isConfirmPassSecure {
                                    SecureField("", text: $signupSigninValidation.confirmPassword)
                                        .foregroundColor(.white)
                                        .font(.body)
                                        .padding(15)
                                        .padding(.leading, -10)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                } else {
                                    TextField("", text: $signupSigninValidation.confirmPassword)
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
                    signup()
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
                .alert(isPresented: $areFieldsIncomplete) {
                    Alert(title: Text("ERROR"), message: Text(authenticationViewModel.errorMessage ?? "All fields must be completed correctly"), dismissButton: .default(Text("Okay")))
                }
            }
            
            NavigationLink(isActive: $areFieldsComplete) {
                DashboardView()
            } label: {
                EmptyView()
            }
        }
    }
    
    func signup() {
        if signupSigninValidation.email.isEmpty || signupSigninValidation.password.isEmpty {
            areFieldsComplete = false
            areFieldsIncomplete = true
        } else if !signupSigninValidation.arePasswordsMatch {
            areFieldsComplete = false
            areFieldsIncomplete = true
        } else {
            authenticationViewModel.createNewUser(email: signupSigninValidation.email, password: signupSigninValidation.password)
            areFieldsIncomplete = false
            areFieldsComplete = true
        }

    }
}

struct SignupFormView_Previews: PreviewProvider {
    static var previews: some View {
        SignupFormView(authenticationViewModel: AuthenticationViewModel(), isSigninActive: .constant(false))
            .preferredColorScheme(.dark)
    }
}
