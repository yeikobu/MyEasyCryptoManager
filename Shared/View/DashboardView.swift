//
//  DashboardView.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 09-03-22.
//

import SwiftUI

let tabs = ["gearshape.fill", "chart.bar.xaxis", "house.fill", "magnifyingglass"]

struct DashboardView: View {
    
    @State var backToLogin = false
    @State var selectedTab = "chart.bar.xaxis"
    
    var body: some View {
        
        CustomTabView()
            .accentColor(.white)
            .transition(.slide)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
    }
    
}

struct TabButtonview: View {
    
    @Binding var selectedTab: String
    var imageName: String
    
    var body: some View {
        Button {
            selectedTab = imageName
        } label: {
            VStack(spacing: 2) {
                Image(systemName: imageName)
                    .foregroundColor(selectedTab == imageName ? Color.yellow : Color.gray)
                    .font(.system(size: 24, weight: .bold))
            }
            .padding(13)
        }

    }
}


struct CustomTabView: View {
    
    @State var selectedTab: String = "chart.bar.xaxis"
    @State var edge: CGFloat = 0.0
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
//            LinearGradient(gradient: Gradient(colors: [Color("Background"), Color("BackgroundGradient1"), Color("Background"), Color("BackgroundGradient1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .ignoresSafeArea()
            
            TabView(selection: $selectedTab) {
                
                Text("Settings")
                    .tag("gearshape.fill")
                
                CoinsListView()
                    .tag("chart.bar.xaxis")
                
                Text("Portfolio")
                    .tag("house.fill")
                
                Text("Search")
                    .tag("magnifyingglass")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { imageName in
                    TabButtonview(selectedTab: $selectedTab, imageName: imageName)
                    if imageName != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 2)
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .shadow(color: .black.opacity(0.70), radius: 8, x: 5, y: 5)
            .shadow(color: .black.opacity(0.70), radius: 8, x: -5, y: -5)
            .padding(.horizontal, 20)
            .padding(.bottom, 1)
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(
            Image("wallpaper4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.85)
        )
        
    }
    
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
