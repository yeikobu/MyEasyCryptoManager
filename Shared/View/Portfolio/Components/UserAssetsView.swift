//
//  UserAssetsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 30-03-22.
//

import SwiftUI

struct UserAssetsView: View {
    
    @ObservedObject var specificCoinVM: SpecificCoinViewModel
    @ObservedObject var favouriteAssetViewModel: FavouriteAssetViewModel
    let gridForm = [GridItem(.flexible())]
    @Binding var isAddedToPorfolio: Bool
    @State var addButtonAnimate: Bool = false
    @Namespace var animation
    @Binding var isTouched: Bool
    
    let buttonAnimationDuration:  Double = 0.15
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    var currentPrice: Double = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Added Assets")
                .foregroundColor(.gray)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding(.bottom, -5)
            
            VStack {
                LazyVGrid(columns: gridForm) {
                    ForEach(favouriteAssetViewModel.favouriteCoins, id: \.self) { asset in
                        UserAssetCardView(name: asset.name ?? "", symbol: asset.symbol ?? "", priceChangePercentage: 2, currentPrice: 45233, imgURL: asset.imgURL ?? "", purchaseQuantity: asset.purchaseQuantity ?? 0, animation: animation, addButtonAnimate: addButtonAnimate, isAddedToPorfolio: isAddedToPorfolio, isTouched: $isTouched)
                            .onAppear {
                                if let selectedCoin = asset.name {
                                    SpecificCoinViewModel(selectedCoin: selectedCoin)
                                }
                            }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .onAppear {
            favouriteAssetViewModel.getAllAssets()
        }
    }
}

struct UserAssetsView_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetsView(specificCoinVM: SpecificCoinViewModel(selectedCoin: ""), favouriteAssetViewModel: FavouriteAssetViewModel(), isAddedToPorfolio: .constant(false), isTouched: .constant(false))
            .preferredColorScheme(.dark)
    }
}
