//
//  CoinsListView.swift
//  MyEasyCryptoManager
//
//  Created by Jacob Aguilar on 16-03-22.
//

import SwiftUI
import Kingfisher

struct CoinsListView: View {
    
    @ObservedObject var coinViewModel: CoinInfoViewModel = CoinInfoViewModel()
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            CoinsMarketListView()
        }
    }
}

struct CoinsMarketListView: View {
    
    @ObservedObject var coinViewModel: CoinInfoViewModel = CoinInfoViewModel()
    @Namespace var animation
    let gridForm = [GridItem(.flexible())]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    //Global market cap stack
                    VStack(alignment: .leading) {
                        Text("Global market cap")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .padding(.vertical, -5)
                        
                        Divider()
                            .background(.gray)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, -10)
                        
                        HStack {
                            Text("$1.893.060.035.101")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                            
                            Image(systemName: "arrowtriangle.up.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 10))
                                .padding(.trailing, -6)
                            
                            Text("2.8%")
                                .foregroundColor(.green)
                                .font(.system(size: 12))
                        }
                        
                    }
                    .padding()
                    .background(Color("Card"))
                    .cornerRadius(10)
                    
                    //24HRS Volume
                    VStack(alignment: .leading) {
                        Text("24 Hours Volume")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .padding(.vertical, -5)
                        
                        Divider()
                            .background(.gray)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, -10)
                        
                        HStack {
                            Text("$106.953.991,010")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                        }
                        
                    }
                    .padding()
                    .background(Color("Card"))
                    .cornerRadius(10)
                }
            }
            .cornerRadius(10)
            .padding(.horizontal, 10)
            
            Divider()
                .background(.gray)
            
            ZStack {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: gridForm) {
                        ForEach(coinViewModel.coinModel, id: \.self) { coin in
                            CoinsDataListView(name: coin.name ?? "", marketCapRank: coin.marketCapRank ?? 0, symbol: coin.symbol ?? "", priceChangePercentage: coin.priceChangePercentage24H ?? 0, currentPrice: coin.currentPrice ?? 0, marketCap: coin.marketCap ?? 0, imgURL: coin.image ?? "")
                        }
                    }
                }
                .cornerRadius(10)
                .padding(.top, 0)
                .padding(.horizontal, 10)
                .ignoresSafeArea()
            }
            
        }
    }
}

struct CoinsDataListView: View {
    
    @State var name: String
    @State var marketCapRank: Int
    @State var symbol: String
    @State var priceChangePercentage: Double
    @State var currentPrice: Double
    @State var marketCap: Int
    @State var imgURL: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: imgURL))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .cornerRadius(50)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .padding(.bottom, -3)

                    HStack {
                        Text("\(marketCapRank)")
                            .font(.system(size: 9, weight: .bold, design: .rounded))
                            .frame(width: 20, height: 16)
                            .background(Color("RankColor"))
                            .cornerRadius(2)
                        
                        Text(symbol.uppercased())
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                    }
                    .padding(.top, 0)
                    
                }
                .frame(maxWidth: 85, alignment: .leading)
                .foregroundColor(.white)
                
                VStack {
                    if priceChangePercentage > 0 {
                        HStack {
                            Image(systemName: "arrowtriangle.up.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 14))
                            
                            Text("\(String(format: "%.2f", priceChangePercentage))%")
                                .foregroundColor(.green)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .frame(alignment: .leading)
                        }
                    }
                    
                    if priceChangePercentage < 0 {
                        HStack {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 14))
                            
                            Text("\(String(format: "%.2f", priceChangePercentage))%")
                                .foregroundColor(.red)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .frame(alignment: .leading)
                        }
                    }
                    
                    if priceChangePercentage == 0 {
                        HStack {
                            Image(systemName: "arrowtriangle.right.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                            
                            Text("\(String(format: "%.2f", priceChangePercentage))%")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .frame(alignment: .leading)
                        }
                    }
                }
                
                VStack(alignment: .trailing) {
                    Text("$\(String(format: "%.2f", currentPrice))")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .padding(.bottom, 2)
                    
                    HStack {
                        
                        Text("M.Cap")
                            .foregroundColor(.gray)
                            .font(.system(size: 8, weight: .regular, design: .rounded))
                        
                        Text("$\(marketCap)")
                            .foregroundColor(.white)
                            .font(.system(size: 8, weight: .regular, design: .rounded))
                            .padding(.leading, -5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
            .padding(.horizontal, 10)
        }
        .padding(.vertical, 5)
        .background(Color("Card"))
        .cornerRadius(10)
        
    }
}

struct CoinsListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsListView()
    }
}
