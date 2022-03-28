//
//  SignInSignUp.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 26-03-22.
//

import SwiftUI

struct SignInSignUp: View {
    var body: some View {
        NavigationView {
            ZStack {
                SignInSignUpHeadView()
                    .background(
                        RoundedRectangle(cornerRadius: 1, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .blur(radius: 1)
                            .opacity(0.8)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("wallpaper2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(0.5)
            )
            
        }
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SignInSignUpHeadView: View {
    
    @State var isSigninActive: Bool = true
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 30) {
                Spacer()
                //Signin button
                Button {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.8)) {
                        isSigninActive = true
                    }
                } label: {
                    Text("Sign in")
                        .foregroundColor(isSigninActive ? .white : .gray)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .matchedGeometryEffect(id: "signin", in: animation)
                }
                
                //Signup button
                Button {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.8)) {
                        isSigninActive = false
                    }
                } label: {
                    Text("Sign up")
                        .foregroundColor(isSigninActive ? .gray : .white)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .matchedGeometryEffect(id: "signup", in: animation)
                }
                
                Spacer()
            }
            .padding(.top, 200)
            
            ZStack {
                if isSigninActive {
                    SigninFormView(authenticationViewModel: AuthenticationViewModel(), isSigninActive: $isSigninActive)
                        .padding(.top, -200)
                }
                
                if !isSigninActive {
                    SignupFormView(authenticationViewModel: AuthenticationViewModel(), isSigninActive: $isSigninActive)
                        .padding(.top, -150)
                }
            }
            
        }
        
    }
}

struct SignInSignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignInSignUp()
            .preferredColorScheme(.dark)
    }
}
