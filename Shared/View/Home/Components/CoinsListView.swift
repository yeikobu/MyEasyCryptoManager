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
            
            CoinsMarketListView(coin: CoinsModel.init())
                .preferredColorScheme(.dark)
        }
    }
}

struct CoinsMarketListView: View {
    
    @StateObject var coinViewModel: CoinInfoViewModel = CoinInfoViewModel()
    @StateObject var globalMarketViewModel: GlobalMarketViewModel = GlobalMarketViewModel()
    @StateObject var specificCoinViewModel: SpecificCoinViewModel = SpecificCoinViewModel()
    @StateObject var haptics: Haptics = Haptics()
    let gridForm = [GridItem(.flexible())]
    @State var mcapChangePercentage: Double = 0
    @State var totalMarketCap: Double = 0
    @State var totalVolume: Double = 0
    @State var activeCryptos: Int = 0
    @State var isMoreInfoClicked: Bool = false
    @State var isTouched: Bool = false
    @State var isListVisible: Bool = false
    @State var isAddedToPorfolio: Bool = false
    @State var addButtonAnimate: Bool = false
    @State var id: String = ""
    @State var imgURL: String = ""
    @State var name: String = ""
    @State var marketCapRank: Int = 0
    @State var symbol: String = ""
    @Namespace var animation
    @State var coin: CoinsModel
    @State var lastAssetID: String = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                if !isTouched {
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
                                    
                                    BasicAssetInfoCardView(name: coin.name ?? "", marketCapRank: coin.marketCapRank ?? 1, symbol: coin.symbol ?? "", priceChangePercentage: coin.priceChangePercentage24H ?? 0, currentPrice: coin.currentPrice ?? 0, marketCap: coin.marketCap ?? 0, imgURL: coin.image ?? "", totalVolume: coin.totalVolume ?? 0, high24H: coin.high24H ?? 0, low24H: coin.low24H ?? 0, maxSupply: coin.maxSupply ?? 0, totalSupply: coin.totalSupply ?? 0, circulatingSupply: coin.circulatingSupply ?? 0, ath: coin.ath ?? 0, atl: coin.atl ?? 0, isTouched: $isTouched, isListVisible: $isListVisible, animation: animation, coin: coin)
                                        .padding(.bottom, self.lastAssetID == coin.id ? 75 : 1)
                                        .task {
                                            getGlobalData()
                                        }
                                        .onTapGesture {
                                            if let id = coin.id {
                                                self.id = id
                                            }
                                            Task {
                                                await specificCoinViewModel.getSpecificCoin(selectedCoin: self.id)
                                            }
                                            if let imgurl = coin.image {
                                                self.imgURL = imgurl
                                            }
                                            if let name = coin.name {
                                                self.name = name
                                            }
                                            if let marketcaprank = coin.marketCapRank {
                                                self.marketCapRank = marketcaprank
                                            }
                                            if let symbol = coin.symbol {
                                                self.symbol = symbol
                                            }
                                            self.coin = coin
                                            
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                                                self.isTouched.toggle()
                                            }
                                            withAnimation(.spring(response: 0.6, dampingFraction: 1)) {
                                                self.isListVisible.toggle()
                                            }
                                        }
                                        .matchedGeometryEffect(id: "\(coin.id ?? "")", in: animation)
                                        
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
                    .onAppear {
                        if let lastAsset = coinViewModel.coinModel.last {
                            self.lastAssetID = lastAsset.id ?? ""
                        }
                    }
                }
                
                
                if isTouched {
                    ZStack(alignment: .topTrailing) {
                        SpecificAssetView(favouriteAssetViewModel: FavouriteAssetViewModel(), imgURL: self.$imgURL, name: self.$name, marketCapRank: self.$marketCapRank, symbol: self.$symbol, coin: self.coin, id: self.$id, isMoreInfoClicked: self.$isMoreInfoClicked, isAddedToPorfolio: self.isAddedToPorfolio, isTouched: self.$isTouched, isListVisible: self.$isListVisible, animation: animation)
                            .padding(.horizontal, 10)
                            .padding(.top, 30)
                            .padding(.bottom, 45)
                        
                        Button {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                self.isTouched.toggle()
                            }
                            withAnimation(.spring(response: 0.5, dampingFraction: 1)) {
                                self.isListVisible.toggle()
                            }
                        } label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(Color("Buttons"))
                                .font(.system(size: 22))
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                        }
                        .padding(.trailing, 10)
                        
                    }
                    .matchedGeometryEffect(id: "\(coin.id ?? "")", in: animation)
                   
                    Spacer()
                }
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
  

struct CoinsListView_Previews: PreviewProvider {
    
    @State static var name: String = "bitcoin"
    
    static var previews: some View {
        CoinsListView()
    }
}
