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
    
    @Binding var name: String
    @Binding var marketCapRank: Int
    @Binding var symbol: String
    @Binding var priceChangePercentage: Double
    @Binding var currentPrice: Double
    @Binding var marketCap: Int
    @Binding var imgURL: String
    @Binding var totalVolume: Double
    @Binding var high24H: Double
    @Binding var low24H: Double
    @Binding var maxSupply: Double
    @Binding var totalSupply: Double
    @Binding var circulatingSupply: Double
    @Binding var ath: Double
    @Binding var atl: Double
    @Binding var isTouched: Bool
    @Binding var isListVisible: Bool
    var animation: Namespace.ID
    @State var engine: CHHapticEngine?
    
    var body: some View {
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

struct CompleteAssetInfoCardView_Previews: PreviewProvider {
    
    @Namespace static var animation
    @State static var name = ""
    @State static var marketCapRank = 2
    @State static var priceChangePercentage = 2.0
    
    static var previews: some View {
        CompleteAssetInfoCardView(name: $name, marketCapRank: $marketCapRank, symbol: $name, priceChangePercentage: $priceChangePercentage, currentPrice: $priceChangePercentage, marketCap: $marketCapRank, imgURL: $name, totalVolume: $priceChangePercentage, high24H: $priceChangePercentage, low24H: $priceChangePercentage, maxSupply: $priceChangePercentage, totalSupply: $priceChangePercentage, circulatingSupply: $priceChangePercentage, ath: $priceChangePercentage, atl: $priceChangePercentage, isTouched: .constant(true), isListVisible: .constant(true), animation: animation)
    }
}
