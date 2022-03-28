//
//  SplashScreenView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 28-03-22.
//

import SwiftUI
import Lottie

struct SplashScreenView: View {
    
    @State var isActive: Bool = false
    @State var showLogin: Bool = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            ZStack {
                if self.isActive {
                    VStack {
                        SigninSignupView()
                            .cornerRadius(isActive ? 30 : 15)
                    }
                    .matchedGeometryEffect(id: "transition", in: animation)
                    .frame(maxWidth: isActive ? .infinity : 50, maxHeight: isActive ? .infinity : 50)
                    .cornerRadius(isActive ? 30 : 15)
                    .ignoresSafeArea()
                } else {
                    VStack {
                        LottieImage(animationName: "", loopMode: .playOnce)
                            .frame(width: 0.5 , height: 0.5)
                    }
                    .matchedGeometryEffect(id: "transition", in: animation)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .cornerRadius(!isActive ? 30 : 15)
                    .ignoresSafeArea()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.spring(response: 0.6, dampingFraction: 1)) {
                        self.isActive = true
                    }
                }
            }
        }
        .background(
            Image("wallpaper2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.5)
        )
        .preferredColorScheme(.dark)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
