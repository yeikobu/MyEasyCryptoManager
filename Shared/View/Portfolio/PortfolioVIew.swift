//
//  UserAssetsView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 30-03-22.
//

import SwiftUI
import Kingfisher

struct PortfolioView: View {
    
    @StateObject var specificCoinVM: SpecificCoinViewModel = SpecificCoinViewModel()
    @StateObject var favouriteAssetViewModel: FavouriteAssetViewModel = FavouriteAssetViewModel()
    @ObservedObject var haptics: Haptics = Haptics()
    let gridForm = [GridItem(.flexible())]
    @State var isAddedToPorfolio: Bool
    @State var addButtonAnimate: Bool = false
    @Namespace var animation
    @Binding var isTouched: Bool
    @State var name: String
    @State var id: String
    @State var symbol: String
    @State var currentPrice: Double
    @State var quantityUSD: Double = 0
    @State var priceChangePercentage: Double = 0
    @State var purchaseQuantity: Double = 0
    @State var imgURL: String = ""
    
    let buttonAnimationDuration:  Double = 0.15
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    
    @State var lastItemID: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Portfolio")
                .foregroundColor(.white)
                .font(.system(size: 28, weight: .black, design: .rounded))
                .padding(.leading, 10)
            
            
//            if favouriteAssetViewModel.favouriteCoins.count > 0 {
                ScrollView(showsIndicators: false) {
                    
                    CurrentBalanceView(currentBalanceUSD: self.$quantityUSD)
                    
                    VStack(alignment: .leading) {
                        Text("Portfolio's Assets")
                            .foregroundColor(.gray)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.bottom, -5)
                            .padding(.top, 10)
                        
                        VStack {
                            LazyVGrid(columns: gridForm) {
                                ForEach(favouriteAssetViewModel.favouriteCoins, id: \.self) { asset in
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            HStack(alignment: .center) {
                                                KFImage(URL(string: asset.imgURL ?? ""))
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 40, height: 40)

                                                Text(asset.name ?? "")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                                    .padding(.bottom, -3)
                                            }
                                            .frame(maxWidth: 120, maxHeight: 40, alignment: .leading)

                                            Spacer()
                                            Spacer()

                                            VStack(alignment: .leading) {
                                                Text("\((asset.currentPrice ?? 0).formatted())")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                                    .padding(.bottom, -4)

                                                    VStack(alignment: .trailing) {
                                                        HStack {
                                                            Image(systemName:  (asset.priceChangePercentage24h ?? 0) > 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                                                                .foregroundColor((asset.priceChangePercentage24h ?? 0) > 0 ? .green : .red)
                                                                .font(.system(size: 8))

                                                            Text("\(String(format: "%.2f", asset.priceChangePercentage24h ?? 0))%")
                                                                .foregroundColor((asset.priceChangePercentage24h ?? 0) > 0 ? .green : .red)
                                                                .font(.system(size: 10, weight: .bold, design: .rounded))
                                                                .frame(alignment: .leading)
                                                                .padding(.leading, -4)
                                                        }
                                                    }
                                            }
                                            .frame(width: 80, height: 40, alignment: .leading)


                                            VStack(alignment: .trailing) {
                                                Text("\(((asset.currentPrice ?? 0) * (asset.purchaseQuantity ?? 0)).formatted())")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                                    .padding(.bottom, -4)

                                                Text("\((asset.purchaseQuantity ?? 0).formatted())")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                                    .padding(.bottom, -4)
                                            }
                                            .frame(width: 80, height: 40, alignment: .trailing)

                                            VStack(alignment: .center) {
                                                Button {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + buttonAnimationDuration) {
                                                        withAnimation(.spring(response: 0.6, dampingFraction: 1)) {
                                                            self.isTouched = true
                                                        }
                                                    }

                                                    self.haptics.addFunctionVibration()

                                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                                        self.isAddedToPorfolio = true
                                                    }
                                                    
                                                    self.name = asset.name ?? ""
                                                    self.id = asset.id ?? ""
                                                    self.currentPrice = asset.currentPrice ?? 0
                                                    self.symbol = asset.symbol ?? ""
                                                    self.imgURL = asset.imgURL ?? ""
                                                    self.priceChangePercentage = asset.priceChangePercentage24h ?? 0
                                                } label: {
                                                    VStack {
                                                        Image(systemName: "plus.app")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 20)
                                                            .foregroundColor(Color("Buttons"))

                                                        Text("Add more")
                                                            .foregroundColor(.gray)
                                                            .font(.system(size: 8))
                                                    }
                                                }
                                                .fullScreenCover(isPresented: $isAddedToPorfolio, content: {
                                                    AddAssetView(isAddedToPorfolio: self.$isAddedToPorfolio, assetName: self.name, assetId: self.id, currentPrice: self.currentPrice, assetSymbol: self.symbol, assetImgURL: self.imgURL, assetChangePercentage: self.priceChangePercentage, animation: animation)
                                                })
                                                .padding(.leading, 1)
                                                .scaleEffect(self.addButtonAnimate ? addButtonScale : 1)
                                            }
                                            .frame(width: 40)
                                        }
                                        .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
                                    }
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(.ultraThinMaterial)
                                            .blur(radius: 0)
                                            .opacity(0.9)
                                    )
                                    .mask(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    )
                                    
                                }
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .task {
                        await favouriteAssetViewModel.getAllAssets()
                        if let last = favouriteAssetViewModel.favouriteCoins.last {
                            self.lastItemID = last.id ?? ""
                        }
                    }
                }
                .cornerRadius(10)
                .padding(.horizontal, 10)
                .ignoresSafeArea()

//            }
            
//            if favouriteAssetViewModel.favouriteCoins.count < 0 {
//                Spacer()
//
//                Text("No assets added to portfolio yet")
//                    .font(.system(size: 20, weight: .bold, design: .rounded))
//                    .frame(maxWidth: .infinity, alignment: .center)
//
//                Spacer()
//            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        
    }
}

struct PortfolioView_Previews: PreviewProvider {
    
    @State static var currentPrice = 47000.2
    @State static var name = "Bitcoin"
    @State static var id = "bitcoin"
    
    static var previews: some View {
        PortfolioView(specificCoinVM: SpecificCoinViewModel(), favouriteAssetViewModel: FavouriteAssetViewModel(), isAddedToPorfolio: false, isTouched: .constant(false), name: name, id: id, symbol: name, currentPrice: currentPrice)
            .preferredColorScheme(.dark)
    }
}
