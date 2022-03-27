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
    let gridForm = [GridItem(.flexible())]
    @State var engine: CHHapticEngine?
    @State var mcapChangePercentage: Double = 0
    @State var totalMarketCap: Double = 0
    @State var totalVolume: Double = 0
    @State var activeCryptos: Int = 0
    @State var isTouched: Bool = false
    
    var body: some View {
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
            
            ZStack {
                RefreshableScrollView(showsIndicators: false) {
                    LazyVGrid(columns: gridForm) {
                        ForEach(coinViewModel.coinModel, id: \.self) { coin in
                            CoinsDataListView(name: coin.name ?? "", marketCapRank: coin.marketCapRank ?? 0, symbol: coin.symbol ?? "", priceChangePercentage: coin.priceChangePercentage24H ?? 0, currentPrice: coin.currentPrice ?? 0, marketCap: coin.marketCap ?? 0, imgURL: coin.image ?? "", totalVolume: coin.totalVolume ?? 0, high24H: coin.high24H ?? 0, low24H: coin.low24H ?? 0, maxSupply: coin.maxSupply ?? 0, totalSupply: coin.totalSupply ?? 0, circulatingSupply: coin.circulatingSupply ?? 0, ath: coin.ath ?? 0, atl: coin.atl ?? 0, isTouched: false, isListVisible: false, isAddedToPorfolio: false, coin: coin)
                                .task {
                                    getGlobalData()
                                }
                        }
                    }
                }
                .cornerRadius(10)
                .padding(.horizontal, 10)
                .ignoresSafeArea()
                .refreshable {
                    coinViewModel.updateInfo()
                    getGlobalData()
                    complexSuccess()
                    try? await Task.sleep(nanoseconds: 1000000000)
                }
            }
        }
        .onAppear {
            prepareHaptics()
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
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return } //If divice dosen't support haptics
        
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
    @State var isAddedToPorfolio: Bool
    @State var addButtonAnimate: Bool = false
    @Namespace var animation
    @State var engine: CHHapticEngine?
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
                                        complexSuccess()
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
                            }
                            
                            ChartView(coin: coin)
                                .offset(x: isListVisible ? 0 : -100, y: isListVisible ? 0 : 0)
                                .padding(.top, 20)
                                .padding(.bottom, 10)
                                .matchedGeometryEffect(id: "chart", in: animation)
                            
                            
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
                    }
                    
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
