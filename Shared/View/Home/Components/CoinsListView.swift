//
//  CoinsListView.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 16-03-22.
//

import SwiftUI
import CoreHaptics
import Kingfisher
import RefreshableScrollView

struct CoinsListView: View {
    
    var body: some View {
        ZStack {
            
            CoinsMarketListView()
                .preferredColorScheme(.dark)
        }
    }
}

struct CoinsMarketListView: View {
    
    @ObservedObject var coinViewModel: CoinInfoViewModel = CoinInfoViewModel()
    @ObservedObject var globalMarketViewModel: GlobalMarketViewModel = GlobalMarketViewModel()
    @ObservedObject var haptics: Haptics = Haptics()
    let gridForm = [GridItem(.flexible())]
    @State var mcapChangePercentage: Double = 0
    @State var totalMarketCap: Double = 0
    @State var totalVolume: Double = 0
    @State var activeCryptos: Int = 0
    @State var isMoreInfoClicked: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Market Information")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .black, design: .rounded))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                    
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        //Global market cap stack
                        VStack(alignment: .leading) {
                            Text("Global Market Cap")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .padding(.vertical, -5)
                            
                            Divider()
                                .background(.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, -10)
                            
                            HStack {
                                Text("$\(Int(totalMarketCap))")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10, weight: .bold, design: .rounded))
                                
                                if mcapChangePercentage > 0 {
                                    Image(systemName: "arrowtriangle.up.fill")
                                        .foregroundColor(.green)
                                        .font(.system(size: 8))
                                        .padding(.trailing, -6)
                                    
                                    Text("\(String(format: "%.2f", mcapChangePercentage))%")
                                        .foregroundColor(.green)
                                        .font(.system(size: 10))
                                } else if mcapChangePercentage < 0 {
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 8))
                                        .padding(.trailing, -6)
                                    
                                    Text("\(String(format: "%.2f", mcapChangePercentage))%")
                                        .foregroundColor(.red)
                                        .font(.system(size: 10))
                                } else {
                                    Image(systemName: "arrowtriangle.right.fill")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 8))
                                        .padding(.trailing, -6)
                                    
                                    Text("\(String(format: "%.2f", mcapChangePercentage))%")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 10))
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .blur(radius: 0)
                                .opacity(0.9)
                        )
                        .cornerRadius(10)
                        
                        //24HRS Volume
                        VStack(alignment: .leading) {
                            Text("24 Hours Volume")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .padding(.vertical, -5)
                            
                            Divider()
                                .background(.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, -10)
                            
                            HStack {
                                Text("$\(Int(totalVolume))")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10, weight: .bold, design: .rounded))
                            }
                            
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .blur(radius: 0)
                                .opacity(0.9)
                        )
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text("Active Cryptocurrencys")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .padding(.vertical, -5)
                            
                            Divider()
                                .background(.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, -10)
                            
                            HStack {
                                Text("\(Int(activeCryptos))")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10, weight: .bold, design: .rounded))
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .blur(radius: 0)
                                .opacity(0.9)
                        )
                        .cornerRadius(10)
                    }
                }
                .cornerRadius(10)
                .padding(.horizontal, 10)
                
                Divider()
                    .background(.gray)
                
                
                VStack {
                    RefreshableScrollView(showsIndicators: false) {
                        LazyVGrid(columns: gridForm) {
                            ForEach(coinViewModel.coinModel, id: \.self) { coin in
                                CoinsDataListView(name: coin.name ?? "", marketCapRank: coin.marketCapRank ?? 0, symbol: coin.symbol ?? "", priceChangePercentage: coin.priceChangePercentage24H ?? 0, currentPrice: coin.currentPrice ?? 0, marketCap: coin.marketCap ?? 0, imgURL: coin.image ?? "", totalVolume: coin.totalVolume ?? 0, high24H: coin.high24H ?? 0, low24H: coin.low24H ?? 0, maxSupply: coin.maxSupply ?? 0, totalSupply: coin.totalSupply ?? 0, circulatingSupply: coin.circulatingSupply ?? 0, ath: coin.ath ?? 0, atl: coin.atl ?? 0, coin: coin)
                                    .task {
                                        getGlobalData()
                                    }
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .refreshable {
                        coinViewModel.updateInfo()
                        getGlobalData()
                        haptics.scrollFunctionVibration()
                        try? await Task.sleep(nanoseconds: 1000000000)
                    }
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                }
                .ignoresSafeArea()
            }
        }
    }
    
    func getGlobalData() {
        //Market cap change percentage 24h
        if let marketCapChangePercentage = globalMarketViewModel.globalMarketModel?.data?.marketCapChangePercentage24HUsd {
            mcapChangePercentage = marketCapChangePercentage
        }
        
        //Total market cap
        if let totalMarketCap = globalMarketViewModel.globalMarketModel?.data?.totalMarketCap {
            for (asset, total) in totalMarketCap {
                if asset == "usd" {
                    self.totalMarketCap = total
                }
            }
        }
        
        //Volume 24 horas
        if let totalVolume24H = globalMarketViewModel.globalMarketModel?.data?.totalVolume {
            for (asset, total) in totalVolume24H {
                if asset == "usd" {
                    self.totalVolume = total
                }
            }
        }
        
        //Total active cryptocurrencys
        if let activeCryptocurrencys = globalMarketViewModel.globalMarketModel?.data?.activeCryptocurrencies {
            activeCryptos = activeCryptocurrencys
        }
    }
}

struct CoinsDataListView: View {
    
    @ObservedObject var haptics: Haptics = Haptics()
    @State var name: String
    @State var marketCapRank: Int
    @State var symbol: String
    @State var priceChangePercentage: Double
    @State var currentPrice: Double
    @State var marketCap: Int
    @State var imgURL: String
    @State var totalVolume: Double
    @State var high24H: Double
    @State var low24H: Double
    @State var maxSupply: Double
    @State var totalSupply: Double
    @State var circulatingSupply: Double
    @State var ath: Double
    @State var atl: Double
    @State var isTouched: Bool = false
    @State var isListVisible: Bool = false
    @State var isAddedToPorfolio: Bool = false
    @State var addButtonAnimate: Bool = false
    @Namespace var animation
    @State var coin: CoinsModel
    
    let buttonAnimationDuration:  Double = 0.15
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                
                if !isTouched {
                    BasicAssetInfoCardView(name: $name, marketCapRank: $marketCapRank, symbol: $symbol, priceChangePercentage: $priceChangePercentage, currentPrice: $currentPrice, marketCap: $marketCap, imgURL: $imgURL, totalVolume: $totalVolume, high24H: $high24H, low24H: $low24H, maxSupply: $maxSupply, totalSupply: $totalSupply, circulatingSupply: $circulatingSupply, ath: $ath, atl: $atl, isTouched: $isTouched, isListVisible: $isListVisible, animation: animation)
                } else {
                    CompleteAssetInfoCardView(name: self.name, marketCapRank: self.marketCapRank, symbol: self.symbol, priceChangePercentage: self.priceChangePercentage, currentPrice: self.currentPrice, marketCap: self.marketCap, imgURL: self.imgURL, totalVolume: self.totalVolume, high24H: self.high24H, low24H: self.low24H, maxSupply: self.maxSupply, totalSupply: self.totalSupply, circulatingSupply: self.circulatingSupply, ath: self.ath, atl: self.atl, isTouched: self.$isTouched, isListVisible: self.$isListVisible, animation: animation, coin: self.coin, isMoreInfoClicked: false, isAddedToPorfolio: self.$isAddedToPorfolio)
                }
                
            }
            .onTapGesture {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.9)) {
                    isTouched.toggle()
                }
                withAnimation(.spring(response: 0.6, dampingFraction: 1)) {
                    isListVisible.toggle()
                }
            }
            
        }
    }
    
}

struct CoinsListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsListView()
    }
}
