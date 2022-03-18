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
    let gridForm = [GridItem(.flexible())]
    @State var engine: CHHapticEngine?
    
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
                RefreshableScrollView(showsIndicators: false) {
                    LazyVGrid(columns: gridForm) {
                        ForEach(coinViewModel.coinModel, id: \.self) { coin in
                            CoinsDataListView(name: coin.name ?? "", marketCapRank: coin.marketCapRank ?? 0, symbol: coin.symbol ?? "", priceChangePercentage: coin.priceChangePercentage24H ?? 0, currentPrice: coin.currentPrice ?? 0, marketCap: coin.marketCap ?? 0, imgURL: coin.image ?? "", totalVolume: coin.totalVolume ?? 0, high24H: coin.high24H ?? 0, low24H: coin.low24H ?? 0, maxSupply: coin.maxSupply ?? 0, totalSupply: coin.totalSupply ?? 0, circulatingSupply: coin.circulatingSupply ?? 0, ath: coin.ath ?? 0, atl: coin.atl ?? 0, isTouched: false, isListVisible: false)
                        }
                    }
                }
                .cornerRadius(10)
                .padding(.horizontal, 10)
                .ignoresSafeArea()
                .refreshable {
                    complexSuccess()
                    try? await Task.sleep(nanoseconds: 1000000000)
                    coinViewModel.updateInfo()
                }
                
                
            }
        }
        .onAppear {
            prepareHaptics()
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return } //If divice not support haptics
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 0.5, by: 0.09) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)
        }
        
//        for i in stride(from: 0.4, to: 0.5, by: 0.15) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0.25)
//            events.append(event)
//        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print(error.localizedDescription)
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
    @State var totalVolume: Double
    @State var high24H: Double
    @State var low24H: Double
    @State var maxSupply: Double
    @State var totalSupply: Double
    @State var circulatingSupply: Double
    @State var ath: Double
    @State var atl: Double
    @State var isTouched: Bool
    @State var isListVisible: Bool
    @Namespace var animation
    @State var engine: CHHapticEngine?
    
    var frame: CGFloat {
        isTouched ? 600 : 55
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                
                if !isTouched {
                    VStack(alignment: .leading) {
                        HStack {
                            HStack {
                                KFImage(URL(string: imgURL))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .matchedGeometryEffect(id: "icon", in: animation)
                                    .frame(width: 40, height: 40)
    //                                .cornerRadius(50)
                                
                                VStack(alignment: .leading) {
                                    Text(name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .bold, design: .rounded))
                                        .matchedGeometryEffect(id: "name", in: animation)
                                        .padding(.bottom, -3)

                                    HStack {
                                        Text("\(marketCapRank)")
                                            .matchedGeometryEffect(id: "rank", in: animation)
                                            .foregroundColor(.white)
                                            .font(.system(size: 9, weight: .bold, design: .rounded))
                                            .padding(5)
                                            .background(Color("RankColor"))
                                            .cornerRadius(2)
                                        
                                        Text(symbol.uppercased())
                                            .matchedGeometryEffect(id: "symbol", in: animation)
                                            .foregroundColor(.white)
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                    }
                                    .padding(.top, 0)
                                }
                            }
                            .frame(width: 125, alignment: .leading)
                            
                            VStack(alignment: .trailing) {
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
                            
                            VStack(alignment: .trailing) {
                                Text("$\(String(format: "%.2f", currentPrice))")
                                    .matchedGeometryEffect(id: "currentPrice", in: animation)
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
                                .matchedGeometryEffect(id: "mcap", in: animation)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            
//                            Button {
//                                //
//                            } label: {
//                                Image(systemName: "star")
//                                    .foregroundColor(.yellow)
//                                    .font(.system(size: 1))
//                            }
//                            .matchedGeometryEffect(id: "favorite", in: animation)
                        }
                        .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
                        .padding(.horizontal, 10)
                        
                        VStack {
                            Text("Asset information")
                                .matchedGeometryEffect(id: "information", in: animation)
                                .foregroundColor(.white)
                                .font(.system(size: 1))
                                .opacity(0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .matchedGeometryEffect(id: "assetInformation", in: animation)
                    }
                    .padding(.vertical, 10)
                    .background(
                        Color("Card")
                            .matchedGeometryEffect(id: "background", in: animation)
                    )
                    .mask(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .matchedGeometryEffect(id: "mask", in: animation)
                    )
                } else {
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
                                .background(Color("RankColor"))
                                .cornerRadius(2)
                            
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
                            
                            Button {
                                //
                                complexSuccess()
                            } label: {
                                Image(systemName: "star")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 16))
                            }
                            .matchedGeometryEffect(id: "favorite", in: animation)
                            .padding(.leading, 5)
                            .offset(x: isListVisible ? 0 : 100, y: 0)
                        }
                        .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
                        .padding(.horizontal, 10)
                        
                        VStack(alignment: .trailing) {
                            HStack {
                                Spacer()
                                Text("$\(currentPrice)")
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
                        }
                        
                        Spacer()
                        
                        VStack {
                            
                            Text("Asset information")
                                .offset(x: isListVisible ? 0 : 100, y: isListVisible ? 0 : -100)
                                .foregroundColor(.white)
                                .font(.system(size: 12, design: .rounded))
                                .padding(.top)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
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
                        Color("Card")
                            .matchedGeometryEffect(id: "background", in: animation)
                    )
                    .mask(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .matchedGeometryEffect(id: "mask", in: animation)
                    )
                }
                
            }
            .onTapGesture {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.75)) {
                    isTouched.toggle()
                }
                withAnimation(.spring(response: 0.6, dampingFraction: 1)) {
                    isListVisible.toggle()
                }
            }
            
        }
        .onAppear {
            prepareHaptics()
        }
    }
    
    func addedToPortfolio() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return } //If divice not support haptics
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 0.5, by: 0.09) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)
        }
        
        for i in stride(from: 0.4, to: 0.5, by: 0.15) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1.2 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0.25)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CoinsListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsListView()
    }
}
