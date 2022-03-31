//
//  PortfolioVIew.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 29-03-22.
//

import SwiftUI
import SwiftUICharts

struct PortfolioVIew: View {
    
    @State var isTouched: Bool = false
    @State var isAddedToPorfolio: Bool = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            if !isTouched {
                ScrollView(showsIndicators: false) {
                    CurrentBalanceView()
                    UserAssetsView(isAddedToPorfolio: $isAddedToPorfolio, isTouched: $isTouched)
                        .padding(.top)
                }
                .matchedGeometryEffect(id: "add", in: animation)
                .transition(.scale)
            } else {
                VStack {
                    AddAssetView(isAddedToPorfolio: $isTouched, animation: animation)
                }
                .matchedGeometryEffect(id: "add", in: animation)
                .transition(.scale)
            }
           
        }
        .preferredColorScheme(.dark)
        
    }
}

struct PortfolioVIew_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioVIew()
            .preferredColorScheme(.dark)
    }
}
