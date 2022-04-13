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
    @State var currentPrice: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Added Assets")
                .foregroundColor(.gray)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding(.bottom, -5)
            
            VStack {
                LazyVGrid(columns: gridForm) {
                    //Getting all asset added to favoutites
                    ForEach(favouriteAssetViewModel.favouriteCoins, id: \.self) { asset in
                        
                        Divider()
                            .onAppear() {
                                if let selectedCoin = asset.name {
                                    specificCoinVM.getSpecificCoin(selectedCoin: selectedCoin)
                                }
                                
                            }
                        
                        //Getting information of a specific asset previously added to favourite
                        ForEach(specificCoinVM.specificCoinModel, id: \.self) { specificAsset in
                            UserAssetCardView(name: asset.name ?? "", symbol: asset.symbol ?? "", priceChangePercentage: 2, currentPrice: specificCoinVM.currentPrice ?? 00, imgURL: asset.imgURL ?? "", purchaseQuantity: asset.purchaseQuantity ?? 0, animation: animation, addButtonAnimate: addButtonAnimate, isAddedToPorfolio: isAddedToPorfolio, isTouched: $isTouched)
                                .task {
                                    if let currentPrice = specificAsset.marketData?.currentPrice["usd"] {
                                        self.currentPrice = currentPrice
                                        print("View current price: \(self.currentPrice)")
                                    }
                                    print("Current price directely \(specificCoinVM.currentPrice ?? 00)")
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
        UserAssetsView(specificCoinVM: SpecificCoinViewModel(), favouriteAssetViewModel: FavouriteAssetViewModel(), isAddedToPorfolio: .constant(false), isTouched: .constant(false), currentPrice: 0)
            .preferredColorScheme(.dark)
    }
}
