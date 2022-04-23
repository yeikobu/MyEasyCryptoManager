//
//  UserAssetsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 30-03-22.
//

import SwiftUI

struct UserAssetsView: View {
    
    @StateObject var specificCoinVM: SpecificCoinViewModel
    @StateObject var favouriteAssetViewModel: FavouriteAssetViewModel
    let gridForm = [GridItem(.flexible())]
    @Binding var isAddedToPorfolio: Bool
    @State var addButtonAnimate: Bool = false
    @Namespace var animation
    @Binding var isTouched: Bool
    
    let buttonAnimationDuration:  Double = 0.15
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    
    @State var counter = 0
    @State var currentPrice: Double = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Added Assets")
                .foregroundColor(.gray)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding(.bottom, -5)
            
            VStack {
                LazyVGrid(columns: gridForm) {
                    ForEach(favouriteAssetViewModel.favouriteCoins, id: \.self) { asset in
                        
                        
                        UserAssetCardView(name: asset.name ?? "", symbol: asset.symbol ?? "", priceChangePercentage: 2, currentPrice: self.currentPrice, imgURL: asset.imgURL ?? "", purchaseQuantity: asset.purchaseQuantity ?? 0, animation: animation, addButtonAnimate: addButtonAnimate, isAddedToPorfolio: isAddedToPorfolio, isTouched: $isTouched)
                            .task {
                                do {
                                    try await specificCoinVM.getCurrentPrice(selectedCoin: asset.id ?? "")
                                    self.currentPrice = specificCoinVM.selectedCoinCurrentPrice ?? 0
                                } catch {
                                    print(error)
                                }
                                
                            }
                            
                    }
                }
            }
            
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .onAppear {
            Task {
                favouriteAssetViewModel.getAllAssets()
            }
        }
        .task {
            
        }
    }
}

struct UserAssetsView_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetsView(specificCoinVM: SpecificCoinViewModel(), favouriteAssetViewModel: FavouriteAssetViewModel(), isAddedToPorfolio: .constant(false), isTouched: .constant(false))
            .preferredColorScheme(.dark)
    }
}
