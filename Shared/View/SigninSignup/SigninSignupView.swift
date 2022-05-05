//
//  SignInSignUp.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 26-03-22.
//

import SwiftUI

struct SigninSignupView: View {
    var body: some View {
        NavigationView {
            ZStack {
                SignInSignUpButtonsView()
                    .frame(maxHeight: .infinity)
//                    .background(
//                        RoundedRectangle(cornerRadius: 1, style: .continuous)
//                            .fill(.ultraThinMaterial)
//                            .ignoresSafeArea()
//                            .blur(radius: 1)
//                            .opacity(0.8)
//                    )
            }
            .frame(maxHeight: .infinity)
            .background(
                Image("wallpaper2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(0.5)
            )
            .preferredColorScheme(.dark)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SignInSignUpButtonsView: View {
    
    @State var isSigninActive: Bool = true
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 30) {
                Spacer()
                //Signin button
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                        isSigninActive = true
                    }
                } label: {
                    Text("Sign in")
                        .foregroundColor(isSigninActive ? .white : .gray)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
//                        .matchedGeometryEffect(id: "signin", in: animation)
                }
                
                //Signup button
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                        isSigninActive = false
                    }
                } label: {
                    Text("Sign up")
                        .foregroundColor(isSigninActive ? .gray : .white)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                }
                
                Spacer()
            }
            
            if isSigninActive {
                SigninFormView(authenticationViewModel: AuthenticationViewModel(), isSigninActive: $isSigninActive)
                    .matchedGeometryEffect(id: "form", in: animation)
//                        .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            
            if !isSigninActive {
                SignupFormView(authenticationViewModel: AuthenticationViewModel(), isSigninActive: $isSigninActive)
                    .matchedGeometryEffect(id: "form", in: animation)
//                        .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
    }
}

struct SigninSignupView_Previews: PreviewProvider {
    static var previews: some View {
        SigninSignupView()
            .preferredColorScheme(.dark)
    }
}
