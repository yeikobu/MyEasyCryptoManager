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
    
    @StateObject var haptics: Haptics = Haptics()
    @StateObject var specificCoinViewModel: SpecificCoinViewModel = SpecificCoinViewModel()
    @StateObject var favouriteAssetViewModel: FavouriteAssetViewModel
    @Binding var imgURL: String
    @Binding var name: String
    @Binding var marketCapRank: Int
    @Binding var symbol: String
    @State var coin = SpecificCoinModel()
    @Binding var id: String
    
    @State var addButtonAnimate: Bool = false
    @Binding var isMoreInfoClicked: Bool
    @State var isAddedToPorfolio: Bool
    @Binding var isTouched: Bool
    @Binding var isListVisible: Bool
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    let buttonAnimationDuration:  Double = 0.15
    
    @State var isRedMorePressed: Bool = false
    var animation: Namespace.ID
    let gridForm = [GridItem(.flexible())]
    
    var body: some View {
        RefreshableScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridForm) {
                VStack(alignment: .leading) {
                    
                    // MARK: - Name, image, market cap rank and symbol
                    HStack {
                        KFImage(URL(string: imgURL))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "icon", in: animation)
                            .frame(width: 50, height: 50)
                        
                        Spacer()
                        Spacer()
                        
                        Text("\(marketCapRank)")
                            .matchedGeometryEffect(id: "rank", in: animation)
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .padding(5)
                            .padding(.top, 3)
                        
                        Text(name)
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .matchedGeometryEffect(id: "name", in: animation)
                            
                        Text(symbol.uppercased())
                            .matchedGeometryEffect(id: "symbol", in: animation)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .padding(.top, 5)
                        
                        Spacer()
                        Spacer()
                        
                        
                        // MARK: - Add to portfolio
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
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                    favouriteAssetViewModel.addFavouriteAsset(id: self.id, name: self.name, symbol: self.symbol, imgURL: self.imgURL, purchasePrice: 0, purchaseQuantity: 0, currentPrice: specificCoinViewModel.selectedCoinCurrentPrice ?? 0, priceChangePercentage24h: 0)
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
                    
                    
                    // MARK: - Price and change price percentage
                    VStack {
                        HStack {
                            Spacer()
                            
                            Text("$\((specificCoinViewModel.selectedCoinCurrentPrice ?? 0).formatted())")
                                .matchedGeometryEffect(id: "currentPrice", in: animation)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .black, design: .rounded))
                                .padding(.bottom, 2)
                            
                            VStack {
                                if specificCoinViewModel.selectedSpecificCoinModel.marketData?.priceChangePercentage24H ?? 0 > 0 {
                                    HStack {
                                        Image(systemName: "arrowtriangle.up.fill")
                                            .foregroundColor(.green)
                                            .font(.system(size: 14))
                                        
                                        Text("\(String(format: "%.2f", specificCoinViewModel.selectedSpecificCoinModel.marketData?.priceChangePercentage24H ?? 0))%")
                                            .foregroundColor(.green)
                                            .font(.system(size: 14, weight: .bold, design: .rounded))
                                            .frame(alignment: .leading)
                                    }
                                }
                                
                                if specificCoinViewModel.selectedSpecificCoinModel.marketData?.priceChangePercentage24H ?? 0 < 0 {
                                    HStack {
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size: 14))
                                        
                                        Text("\(String(format: "%.2f", specificCoinViewModel.selectedSpecificCoinModel.marketData?.priceChangePercentage24H ?? 0))%")
                                            .foregroundColor(.red)
                                            .font(.system(size: 14, weight: .bold, design: .rounded))
                                            .frame(alignment: .leading)
                                    }
                                }
                                
                                if specificCoinViewModel.selectedSpecificCoinModel.marketData?.priceChangePercentage24H ?? 0 == 0 {
                                    HStack {
                                        Image(systemName: "arrowtriangle.right.fill")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14))
                                        
                                        Text("\(String(format: "%.2f", specificCoinViewModel.selectedSpecificCoinModel.marketData?.priceChangePercentage24H ?? 0))%")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .bold, design: .rounded))
                                            .frame(alignment: .leading)
                                    }
                                }
                            }
                            .matchedGeometryEffect(id: "priceChangePercentage", in: animation)
                            Spacer()
                        }
                    }
                    
                    // MARK: - Line chart
                    VStack {
                        ChartWithSpecificAssetModelView(coin: coin)
                            .offset(x: isListVisible ? 0 : -100, y: isListVisible ? 0 : 0)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                            .matchedGeometryEffect(id: "chart", in: animation)
                    }
                    .padding(5)
                    
                    
                    // MARK: - Asset description
                    VStack(alignment: .leading) {
                        Text("About \(self.name.capitalizingFirstLetter()): ")
                            .font(.system(size: 12, design: .rounded))
                            .offset(x: isListVisible ? 0 : -100, y: 0)
                        
                        if !isRedMorePressed {
                            Text("\(specificCoinViewModel.selectedCoinDescription ?? "")")
                                .matchedGeometryEffect(id: "description", in: animation)
                                .font(.system(size: 10, design: .rounded))
                                .frame(maxHeight: 100)
                                .offset(x: isListVisible ? 0 : -100, y: 0)
                            
                            Text("Show more...")
                                .matchedGeometryEffect(id: "showMoreLess", in: animation)
                                .foregroundColor(Color(.white))
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                                .font(.system(size: 12, design: .rounded))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .onTapGesture {
                                    withAnimation() {
                                        self.isRedMorePressed = true
                                    }
                                }
                                .offset(x: isListVisible ? 0 : 100, y: 0)
                        } else {
                            Text("\(specificCoinViewModel.selectedCoinDescription ?? "")")
                                .matchedGeometryEffect(id: "CompleteDescription", in: animation)
                                .font(.system(size: 10, design: .rounded))
                                .frame(maxHeight: .infinity)
                            
                            Text("Show less...")
                                .matchedGeometryEffect(id: "showMoreLess", in: animation)
                                .foregroundColor(Color(.white))
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
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
                    
                    
                    // MARK: - AssetInformation
                    VStack {
                        VStack {
                            Text("Asset information")
                                .offset(x: isListVisible ? 0 : -100, y: 0)
                                .foregroundColor(.white)
                                .font(.system(size: 12, design: .rounded))
                                .padding(.top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        HStack {
                            Text("Market Cap")
                                .offset(x: isListVisible ? 0 : -200, y: 0)
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                            Spacer()
                            Text("$\((specificCoinViewModel.selectedSpecificCoinModel.marketData?.marketCap["usd"] ?? 0).formatted())")
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
                            Text("$\(Int(specificCoinViewModel.selectedSpecificCoinModel.marketData?.totalVolume["usd"] ?? 0))")
                                .offset(x: isListVisible ? 0 : 500, y: 0)
                                .foregroundColor(.white)
                                .font(.system(size: 9))
                        }
                        .padding(.top, 1)
                        
                        Divider()
                            .background(.gray)
                        
                        VStack {
                            HStack {
                                Text("24H High Price")
                                    .offset(x: isListVisible ? 0 : -800, y: 0)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 9))
                                Spacer()
                                Text("$\((specificCoinViewModel.selectedSpecificCoinModel.marketData?.high24H["usd"] ?? 0).formatted())")
                                    .offset(x: isListVisible ? 0 : 800, y: 0)
                                    .foregroundColor(.white)
                                    .font(.system(size: 9))
                            }
                            .padding(.top, 1)
                            
                            Divider()
                                .background(.gray)
                            
                            HStack {
                                Text("24H Low Price")
                                    .offset(x: isListVisible ? 0 : -1100, y: 0)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 9))
                                Spacer()
                                Text("$\((specificCoinViewModel.selectedSpecificCoinModel.marketData?.low24H["usd"] ?? 0).formatted())")
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
                                Text("\(Int(specificCoinViewModel.selectedSpecificCoinModel.marketData?.maxSupply ?? 0))")
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
                                Text("\(Int(specificCoinViewModel.selectedSpecificCoinModel.marketData?.totalSupply ?? 0))")
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
                                Text("\(Int(specificCoinViewModel.selectedSpecificCoinModel.marketData?.circulatingSupply ?? 0))")
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
                                Text("$\((specificCoinViewModel.selectedSpecificCoinModel.marketData?.ath["usd"] ?? 0).formatted())")
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
                                Text("$\((specificCoinViewModel.selectedSpecificCoinModel.marketData?.atl["usd"] ?? 0).formatted())")
                                    .offset(x: isListVisible ? 0 : 2600, y: 0)
                                    .foregroundColor(.white)
                                    .font(.system(size: 9))
                            }
                            .padding(.top, 1)
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .padding(.vertical, 10)
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
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                .padding(.horizontal, 5)
                .onAppear {
                    Task {
                        await specificCoinViewModel.getSpecificCoin(selectedCoin: self.id)
                        self.favouriteAssetViewModel.checkIsAssetLiked(id: self.id) { result in
                            if result {
                                self.isAddedToPorfolio = true
                            } else {
                                self.isAddedToPorfolio = false
                            }
                        }
                    }
                }
                .preferredColorScheme(.dark)
            }
        }
        .onAppear {
            Task {
                self.coin = try await self.specificCoinViewModel.getCoinAndReturnTheModel(selectedCoin: self.id)
            }
        }
        .refreshable {
            await specificCoinViewModel.getSpecificCoin(selectedCoin: self.id)
            haptics.scrollFunctionVibration()
            try? await Task.sleep(nanoseconds: 1000000000)
        }
        .cornerRadius(10)
        
    }
}

//struct CompleteAssetInfoCardView_Previews: PreviewProvider {
//
//    @Namespace static var animation
//    @State static var name = ""
//    @State static var marketCapRank = 2
//    @State static var priceChangePercentage = 2.0
//
//    static var previews: some View {
//        CompleteAssetInfoCardView(name: "Bitcoin", marketCapRank: 1, symbol: "btc", priceChangePercentage: 2, currentPrice: 47000, marketCap: 12121212, imgURL: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", totalVolume: 1212121, high24H: 121221212, low24H: 121221, maxSupply: 121212, totalSupply: 12211, circulatingSupply: 1212, ath: 1212, atl: 121212, isTouched: .constant(false), isListVisible: .constant(false), animation: animation, coin: SpecificCoinModel.init(), isMoreInfoClicked: false, isAddedToPorfolio: .constant(false), id: "bitcoin")
//            .preferredColorScheme(.dark)
//    }
//}
