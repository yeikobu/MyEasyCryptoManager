//
//  UserAssetsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 30-03-22.
//

import SwiftUI

struct UserAssetsView: View {
    
    @StateObject var specificCoinVM: SpecificCoinViewModel = SpecificCoinViewModel()
    @StateObject var favouriteAssetViewModel: FavouriteAssetViewModel = FavouriteAssetViewModel()
    let gridForm = [GridItem(.flexible())]
    @Binding var isAddedToPorfolio: Bool
    @State var addButtonAnimate: Bool = false
    @Namespace var animation
    @Binding var isTouched: Bool
    
    let buttonAnimationDuration:  Double = 0.15
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    
    @State var lastItemID: String = ""
    
    @State var counter = 0
    @State var currentPrice: Double = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Portfolio's Assets")
                .foregroundColor(.gray)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding(.bottom, -5)
            
            VStack {
                LazyVGrid(columns: gridForm) {
                    ForEach(favouriteAssetViewModel.favouriteCoins, id: \.self) { asset in
                        
                        UserAssetCardView(name: asset.name ?? "", symbol: asset.symbol ?? "", priceChangePercentage: asset.priceChangePercentage24h ?? 0, currentPrice: asset.currentPrice ?? 0, imgURL: asset.imgURL ?? "", purchaseQuantity: asset.purchaseQuantity ?? 0, animation: animation, addButtonAnimate: addButtonAnimate, isAddedToPorfolio: isAddedToPorfolio, isTouched: $isTouched)
                            .padding(.bottom, lastItemID == asset.id ? 65 : 1)
                            
                    }
                }
            }
            
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .onAppear {
            Task {
                await favouriteAssetViewModel.getAllAssets()
                if let last = favouriteAssetViewModel.favouriteCoins.last {
                    self.lastItemID = last.id ?? ""
                }
            }
        }
    }
}

struct UserAssetsView_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetsView(specificCoinVM: SpecificCoinViewModel(), favouriteAssetViewModel: FavouriteAssetViewModel(), isAddedToPorfolio: .constant(false), isTouched: .constant(false))
            .preferredColorScheme(.dark)
    }
}
