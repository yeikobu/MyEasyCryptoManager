//
//  CompleteAssetInfoCardView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 18-03-22.
//

import SwiftUI
import CoreHaptics
import Kingfisher
import RefreshableScrollView

struct CompleteAssetInfoCardView: View {
    
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
    @Binding var isTouched: Bool
    @Binding var isListVisible: Bool
    var animation: Namespace.ID
    @State var coin: CoinsModel
    @State var addButtonAnimate: Bool = false
    @State var isMoreInfoClicked: Bool
    @Binding var isAddedToPorfolio: Bool
    let buttonAnimationDuration:  Double = 0.15
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    KFImage(URL(string: imgURL))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "icon", in: animation)
                        .frame(width: 40, height: 40)
                    
                    Spacer()
                    Spacer()
                    
                    Text("\(marketCapRank)")
                        .matchedGeometryEffect(id: "rank", in: animation)
                        .foregroundColor(.white)
                        .font(.system(size: 9, weight: .bold, design: .rounded))
                        .padding(5)
                    
                    Text(name)
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .matchedGeometryEffect(id: "name", in: animation)
                        
                    Text(symbol.uppercased())
                        .matchedGeometryEffect(id: "symbol", in: animation)
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                    
                    Spacer()
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Button {

                            haptics.addFunctionVibration()
                            addButtonAnimate = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + buttonAnimationDuration) {
                                withAnimation(.spring(response: buttonAnimationDuration, dampingFraction: 1)) {
                                    addButtonAnimate = false
                                    isAddedToPorfolio.toggle()
                                }
                            }
                        } label: {
                            VStack {
                                Image(systemName: isAddedToPorfolio ? "plus.app.fill" : "plus.app")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20)
                                    .foregroundColor(isAddedToPorfolio ? .yellow : .gray)
                                
                                Text(isAddedToPorfolio ? "Added!" : "Add")
                                    .foregroundColor(isAddedToPorfolio ? .yellow : .gray)
                                    .font(.system(size: 8))
                            }
                        }
                        .matchedGeometryEffect(id: "favorite", in: animation)
                        .padding(.leading, 5)
                        .scaleEffect(addButtonAnimate ? addButtonScale : 1)
                        .offset(x: isListVisible ? 0 : 200, y: 0)
                    }
                    .frame(width: 40)
                    
                    
                }
                .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
                .padding(.horizontal, 10)
                
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        Text("$\(currentPrice.formatted())")
                            .matchedGeometryEffect(id: "currentPrice", in: animation)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .padding(.bottom, 2)
                        
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
                        .matchedGeometryEffect(id: "priceChangePercentage", in: animation)
                        Spacer()
                    }
                    
                    ChartView(coin: coin)
                        .offset(x: isListVisible ? 0 : -100, y: isListVisible ? 0 : 0)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        .matchedGeometryEffect(id: "chart", in: animation)
                }
                
                
                VStack {
                    HStack {
                        Text("Asset information")
                            .offset(x: isListVisible ? 0 : 100, y: isListVisible ? 0 : -100)
                            .foregroundColor(.white)
                            .font(.system(size: 12, design: .rounded))
                            .padding(.top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        //Link to SpecificAssetView
                        Button {
                            self.isMoreInfoClicked = true
                            print(self.isMoreInfoClicked)
                        } label: {
                            HStack(spacing: 2) {
                                Text("More info")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12, design: .rounded))
                                
                                Image(systemName: "arrowtriangle.forward.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10, design: .rounded))
                                    .padding(.leading, 0)
                            }
                            .padding(.top)
                        }

                    }
                    
                    HStack {
                        Text("Market Cap")
                            .offset(x: isListVisible ? 0 : -200, y: 0)
                            .foregroundColor(.gray)
                            .font(.system(size: 9))
                        Spacer()
                        Text("$\(marketCap)")
                            .offset(x: isListVisible ? 0 : 200, y: 0)
                            .foregroundColor(.white)
                            .font(.system(size: 9))
                    }
                    .padding(.top, 1)
                    
                    Divider()
                        .background(.gray)
                    
                    HStack {
                        Text("Total volume")
                            .offset(x: isListVisible ? 0 : -500, y: 0)
                            .foregroundColor(.gray)
                            .font(.system(size: 9))
                        Spacer()
                        Text("$\(Int(totalVolume))")
                            .offset(x: isListVisible ? 0 : 500, y: 0)
                            .foregroundColor(.white)
                            .font(.system(size: 9))
                    }
                    .padding(.top, 1)
                    
                    Divider()
                        .background(.gray)
                    
                    VStack {
                        HStack {
                            Text("24H High")
                                .offset(x: isListVisible ? 0 : -800, y: 0)
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("$\(high24H)")
                                .offset(x: isListVisible ? 0 : 800, y: 0)
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                        
                        HStack {
                            Text("24H Low")
                                .offset(x: isListVisible ? 0 : -1100, y: 0)
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("$\(low24H)")
                                .offset(x: isListVisible ? 0 : 1100, y: 0)
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                        
                    }
                    
                    VStack {
                        HStack {
                            Text("Max. Supply")
                                .offset(x: isListVisible ? 0 : -1400, y: 0)
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("\(Int(maxSupply))")
                                .offset(x: isListVisible ? 0 : 1400, y: 0)
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                        
                        HStack {
                            Text("Total Supply")
                                .offset(x: isListVisible ? 0 : -1700, y: 0)
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("\(Int(totalSupply))")
                                .offset(x: isListVisible ? 0 : 1700, y: 0)
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                        
                        HStack {
                            Text("Circulating Supply")
                                .offset(x: isListVisible ? 0 : -2000, y: 0)
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("\(Int(circulatingSupply))")
                                .offset(x: isListVisible ? 0 : 2000, y: 0)
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                    }
                    
                    VStack {
                        HStack {
                            Text("All time high")
                                .offset(x: isListVisible ? 0 : -2300, y: 0)
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                            Spacer()
                            Text("$\(ath)")
                                .offset(x: isListVisible ? 0 : 2300, y: 0)
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                        
                        HStack {
                            Text("All time low")
                                .offset(x: isListVisible ? 0 : -2600, y: 0)
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("$\(atl)")
                                .offset(x: isListVisible ? 0 : 2600, y: 0)
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                    }
                }
                .offset(x: 0, y: isListVisible ? 0 : 10)
                .matchedGeometryEffect(id: "assetInformation", in: animation)
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .blur(radius: 0)
                    .opacity(0.9)
                    .matchedGeometryEffect(id: "background", in: animation)
            )
            .mask(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: animation)
            )
            
            NavigationLink(isActive: $isMoreInfoClicked) {
                SpecificAssetView(name: $name)
            } label: {
                EmptyView()
            }
        }
    }
}

struct CompleteAssetInfoCardView_Previews: PreviewProvider {
    
    @Namespace static var animation
    @State static var name = ""
    @State static var marketCapRank = 2
    @State static var priceChangePercentage = 2.0
    
    static var previews: some View {
        CompleteAssetInfoCardView(name: "Bitcoin", marketCapRank: 1, symbol: "btc", priceChangePercentage: 2, currentPrice: 47000, marketCap: 12121212, imgURL: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", totalVolume: 1212121, high24H: 121221212, low24H: 121221, maxSupply: 121212, totalSupply: 12211, circulatingSupply: 1212, ath: 1212, atl: 121212, isTouched: .constant(false), isListVisible: .constant(false), animation: animation, coin: CoinsModel(id: dev.coin.id, symbol: dev.coin.symbol, name: dev.coin.name, image: dev.coin.image, currentPrice: dev.coin.currentPrice, marketCap: dev.coin.marketCap, marketCapRank: dev.coin.marketCapRank, fullyDilutedValuation: dev.coin.fullyDilutedValuation, totalVolume: dev.coin.totalVolume, high24H: dev.coin.high24H, low24H: dev.coin.low24H, priceChange24H: dev.coin.priceChange24H, priceChangePercentage24H: dev.coin.priceChangePercentage24H, marketCapChange24H: dev.coin.marketCapChange24H, marketCapChangePercentage24H: dev.coin.priceChangePercentage24H, circulatingSupply: dev.coin.circulatingSupply, totalSupply: dev.coin.totalSupply, maxSupply: dev.coin.maxSupply, ath: dev.coin.ath, athChangePercentage: dev.coin.athChangePercentage, athDate: dev.coin.athDate, atl: dev.coin.atl, atlChangePercentage: dev.coin.atlChangePercentage, atlDate: dev.coin.athDate, lastUpdated: dev.coin.lastUpdated, sparkLine7D: dev.coin.sparkLine7D), isMoreInfoClicked: false, isAddedToPorfolio: .constant(false))
            .preferredColorScheme(.dark)
    }
}
