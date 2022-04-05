//
//  UserAssetsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 30-03-22.
//

import SwiftUI

struct UserAssetsView: View {
    
    @ObservedObject var favouriteAssetViewModel: FavouriteAssetViewModel
    let gridForm = [GridItem(.flexible())]
    @State var name: String = "Bitcoin"
    @State var marketCapRank: Int = 1
    @State var symbol: String = "btc"
    @State var priceChangePercentage: Double = 2.1
    @State var currentPrice: Double = 47000.2
    @State var marketCap: Int = 8000000000
    @State var imgURL: String = "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579"
    @Binding var isAddedToPorfolio: Bool
    @State var addButtonAnimate: Bool = false
    @Namespace var animation
    @Binding var isTouched: Bool
    
    let buttonAnimationDuration:  Double = 0.15
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Added Assets")
                .foregroundColor(.gray)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding(.bottom, -5)
            
            VStack {
                LazyVGrid(columns: gridForm) {
                    ForEach(favouriteAssetViewModel.favouriteCoins, id: \.self) { asset in
                        UserAssetCardView(name: asset.id ?? "", symbol: asset.symbol ?? "", priceChangePercentage: asset.priceChangePercentage ?? 0, currentPrice: asset.currentPrice ?? 0, imgURL: asset.imgURL ?? "", animation: animation, addButtonAnimate: addButtonAnimate, isAddedToPorfolio: isAddedToPorfolio, isTouched: $isTouched)
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
        UserAssetsView(favouriteAssetViewModel: FavouriteAssetViewModel(), isAddedToPorfolio: .constant(false), isTouched: .constant(false))
            .preferredColorScheme(.dark)
    }
}
