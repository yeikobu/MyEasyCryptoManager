//
//  SpecificAssetView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 14-04-22.
//

import SwiftUI
import Kingfisher
import RefreshableScrollView

struct SpecificAssetView: View {
    
    @Binding var name: String
    @Binding var imgURL: String
    @Binding var marketCapRank: Int
    @Binding var id: String
    @State var coin: CoinsModel
    @State var isBackButtonPressed: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                
                AssetView(imgURL: imgURL, name: name, marketCapRank: 1, symbol: "BTC", coin: self.coin, id: id, isTouched: .constant(false), isAddedToPorfolio: .constant(false), isListVisible: .constant(false))
                    .padding(.top, 25)
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .padding(.bottom, 10)
                        .padding(.horizontal, 10)
                }

                NavigationLink(isActive: $isBackButtonPressed) {
                    DashboardView()
                } label: {
                    EmptyView()
                }

            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("wallpaper2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(0.4)
            )
            .preferredColorScheme(.dark)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(false)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
    
struct AssetView: View {
    
    @ObservedObject var haptics: Haptics = Haptics()
    @ObservedObject var specificCoinViewModel: SpecificCoinViewModel = SpecificCoinViewModel()
    @State var imgURL: String
    @State var name: String
    @State var marketCapRank: Int
    @State var symbol: String
    @State var coin: CoinsModel
    @State var id: String
    
    @Binding var isTouched: Bool
    @Binding var isAddedToPorfolio: Bool
    @State var addButtonAnimate: Bool = false
    @Binding var isListVisible: Bool
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    let buttonAnimationDuration:  Double = 0.15
    
    @State var isRedMorePressed: Bool = false
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                KFImage(URL(string: imgURL))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                Spacer()
                Spacer()
                
                Text("\(marketCapRank)")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .padding(5)
                    .padding(.top, 3)
                
                Text(name.capitalizingFirstLetter())
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    
                Text(symbol.uppercased())
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .padding(.top, 5)
                
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
                    .padding(.leading, 5)
                    .scaleEffect(addButtonAnimate ? addButtonScale : 1)
                }
                .frame(width: 40)
                
                
            }
            .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
            .padding(.horizontal, 10)
            
            //Price and change price stack
            VStack {
                HStack {
                    Spacer()
                    
                    Text("$\((specificCoinViewModel.selectedCoinCurrentPrice ?? 0).formatted())")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .black, design: .rounded))
                        .padding(.bottom, 2)
                    
                    VStack {
                        if specificCoinViewModel.selectedSpecificCoinModel?.marketData?.priceChangePercentage24H ?? 0 > 0 {
                            HStack {
                                Image(systemName: "arrowtriangle.up.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 14))
                                
                                Text("\(String(format: "%.2f", specificCoinViewModel.selectedSpecificCoinModel?.marketData?.priceChangePercentage24H ?? 0))%")
                                    .foregroundColor(.green)
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .frame(alignment: .leading)
                            }
                        }
                        
                        if specificCoinViewModel.selectedSpecificCoinModel?.marketData?.priceChangePercentage24H ?? 0 < 0 {
                            HStack {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 14))
                                
                                Text("\(String(format: "%.2f", specificCoinViewModel.selectedSpecificCoinModel?.marketData?.priceChangePercentage24H ?? 0))%")
                                    .foregroundColor(.red)
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .frame(alignment: .leading)
                            }
                        }
                        
                        if specificCoinViewModel.selectedSpecificCoinModel?.marketData?.priceChangePercentage24H ?? 0 == 0 {
                            HStack {
                                Image(systemName: "arrowtriangle.right.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                                
                                Text("\(String(format: "%.2f", specificCoinViewModel.selectedSpecificCoinModel?.marketData?.priceChangePercentage24H ?? 0))%")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .frame(alignment: .leading)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            
            ScrollView {
                VStack {
                    ChartView(coin: coin)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                }
                .padding(5)
                
                VStack(alignment: .leading) {
                    Text("About \(self.name.capitalizingFirstLetter()): ")
                        .font(.system(size: 12, design: .rounded))
                    
                    if !isRedMorePressed {
                        Text("\(specificCoinViewModel.selectedCoinDescription ?? "")")
                            .matchedGeometryEffect(id: "description", in: animation)
                            .font(.system(size: 10, design: .rounded))
                            .frame(maxHeight: 100)
                        
                        Text("Show more...")
                            .matchedGeometryEffect(id: "showMoreLess", in: animation)
                            .foregroundColor(.white)
                            .font(.system(size: 12, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .onTapGesture {
                                withAnimation() {
                                    self.isRedMorePressed = true
                                }
                            }
                    } else {
                        Text("\(specificCoinViewModel.selectedCoinDescription ?? "")")
                            .matchedGeometryEffect(id: "CompleteDescription", in: animation)
                            .font(.system(size: 10, design: .rounded))
                            .frame(maxHeight: .infinity)
                        
                        Text("Show less...")
                            .matchedGeometryEffect(id: "showMoreLess", in: animation)
                            .foregroundColor(.white)
                            .font(.system(size: 12, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .onTapGesture {
                                withAnimation() {
                                    self.isRedMorePressed = false
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                
                VStack {
                    VStack {
                        Text("Asset information")
                            .foregroundColor(.white)
                            .font(.system(size: 12, design: .rounded))
                            .padding(.top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    HStack {
                        Text("Market Cap")
                            .foregroundColor(.gray)
                            .font(.system(size: 9))
                        Spacer()
                        Text("$\((specificCoinViewModel.selectedSpecificCoinModel?.marketData?.marketCap["usd"] ?? 0).formatted())")
                            .foregroundColor(.white)
                            .font(.system(size: 9))
                    }
                    .padding(.top, 1)
                    
                    Divider()
                        .background(.gray)
                    
                    HStack {
                        Text("Total volume")
                            .foregroundColor(.gray)
                            .font(.system(size: 9))
                        Spacer()
                        Text("$\(Int(specificCoinViewModel.selectedSpecificCoinModel?.marketData?.totalVolume["usd"] ?? 0))")
                            .foregroundColor(.white)
                            .font(.system(size: 9))
                    }
                    .padding(.top, 1)
                    
                    Divider()
                        .background(.gray)
                    
                    VStack {
                        HStack {
                            Text("24H High Price")
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("$\((specificCoinViewModel.selectedSpecificCoinModel?.marketData?.high24H["usd"] ?? 0).formatted())")
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                        
                        HStack {
                            Text("24H Low Price")
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("$\((specificCoinViewModel.selectedSpecificCoinModel?.marketData?.low24H["usd"] ?? 0).formatted())")
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
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("\(Int(specificCoinViewModel.selectedSpecificCoinModel?.marketData?.maxSupply ?? 0))")
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                        
                        HStack {
                            Text("Total Supply")
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("\(Int(specificCoinViewModel.selectedSpecificCoinModel?.marketData?.totalSupply ?? 0))")
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                        
                        HStack {
                            Text("Circulating Supply")
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("\(Int(specificCoinViewModel.selectedSpecificCoinModel?.marketData?.circulatingSupply ?? 0))")
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
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                            Spacer()
                            Text("$\((specificCoinViewModel.selectedSpecificCoinModel?.marketData?.ath["usd"] ?? 0).formatted())")
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                        
                        HStack {
                            Text("All time low")
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("$\((specificCoinViewModel.selectedSpecificCoinModel?.marketData?.atl["usd"] ?? 0).formatted())")
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                    }
                }
                .padding(.horizontal, 10)
            }
            .cornerRadius(15)
            
        }
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.ultraThinMaterial)
                .blur(radius: 0)
                .opacity(0.9)
        )
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .onAppear {
            specificCoinViewModel.getSpecificCoin(selectedCoin: self.id)
            print(specificCoinViewModel.specificCoinModel)
            print(self.id)
        }
        
    }
}

struct SpecificAssetView_Previews: PreviewProvider {
    
    @State static var name: String = "bitcoin"
    @State static var rank: Int = 1
    @State static var img: String = dev.coin.image!
    
    static var previews: some View {
        SpecificAssetView(name: $name, imgURL: $img, marketCapRank: $rank, id: $name, coin: CoinsModel(id: dev.coin.id, symbol: dev.coin.symbol, name: dev.coin.name, image: dev.coin.image, currentPrice: dev.coin.currentPrice, marketCap: dev.coin.marketCap, marketCapRank: dev.coin.marketCapRank, fullyDilutedValuation: dev.coin.fullyDilutedValuation, totalVolume: dev.coin.totalVolume, high24H: dev.coin.high24H, low24H: dev.coin.low24H, priceChange24H: dev.coin.priceChange24H, priceChangePercentage24H: dev.coin.priceChangePercentage24H, marketCapChange24H: dev.coin.marketCapChange24H, marketCapChangePercentage24H: dev.coin.priceChangePercentage24H, circulatingSupply: dev.coin.circulatingSupply, totalSupply: dev.coin.totalSupply, maxSupply: dev.coin.maxSupply, ath: dev.coin.ath, athChangePercentage: dev.coin.athChangePercentage, athDate: dev.coin.athDate, atl: dev.coin.atl, atlChangePercentage: dev.coin.atlChangePercentage, atlDate: dev.coin.athDate, lastUpdated: dev.coin.lastUpdated, sparkLine7D: dev.coin.sparkLine7D))
    }
}
