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
    @State var isCardTouched: Bool = false
    @State var isAddedToPorfolio: Bool = false
    @Namespace var animation
    
    @State var name: String = "Bitcoin"
    @State var marketCapRank: Int = 1
    @State var symbol: String = "btc"
    @State var priceChangePercentage: Double = 12212
    @State var currentPrice: Double = 342134
    @State var marketCap: Int = 123123123
    @State var imgURL: String = "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579"
    @State var totalVolume: Double = 123123123
    @State var high24H: Double = 123123
    @State var low24H: Double = 123123
    @State var maxSupply: Double = 123123
    @State var totalSupply: Double = 123123
    @State var circulatingSupply: Double = 123123
    @State var ath: Double = 123123
    @State var atl: Double = 123123
    @State var isListVisible: Bool = false
    @State var addButtonAnimate: Bool = false
    
    
    var body: some View {
        ZStack {
            VStack {
                if !isTouched && !isCardTouched {
                    ScrollView(showsIndicators: false) {
                        CurrentBalanceView()
                        UserAssetsView(isAddedToPorfolio: $isAddedToPorfolio, isTouched: $isTouched)
                            .padding(.top)
                            .onTapGesture {
                                self.isCardTouched = true
                            }
                    }
                    .matchedGeometryEffect(id: "add", in: animation)
                    .transition(.scale)
                }
                
                if isTouched {
                    VStack {
                        AddAssetView(isAddedToPorfolio: $isTouched, animation: animation)
                    }
                    .matchedGeometryEffect(id: "add", in: animation)
                    .transition(.scale)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                if isCardTouched {
                    VStack {
//                        CompleteAssetInfoCardView(name: $name, marketCapRank: $marketCapRank, symbol: $symbol, priceChangePercentage: $priceChangePercentage, currentPrice: $currentPrice, marketCap: $marketCapRank, imgURL: $imgURL, totalVolume: $totalVolume, high24H: $high24H, low24H: $low24H, maxSupply: $maxSupply, totalSupply: $totalSupply, circulatingSupply: $circulatingSupply, ath: $ath, atl: $atl, isTouched: $isTouched, isListVisible: $isListVisible, animation: animation)
                    }
                    .matchedGeometryEffect(id: "assetMarketInfor", in: animation)
                }
                
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
