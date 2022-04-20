//
//  BasicAssetInfoCardView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 18-03-22.
//

import SwiftUI
import CoreHaptics
import Kingfisher
import RefreshableScrollView

struct BasicAssetInfoCardView: View {
    
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
    @State var engine: CHHapticEngine?
    @State var coin: CoinsModel
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack {
                    KFImage(URL(string: coin.image ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)

                    VStack(alignment: .leading) {
                        Text(coin.name ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .padding(.bottom, -3)

                        HStack {
                            Text("\(coin.marketCapRank ?? 0)")
                                .foregroundColor(.white)
                                .font(.system(size: 9, weight: .bold, design: .rounded))
                                .padding(5)

                            Text(symbol.uppercased())
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                        }
                        .padding(.top, 0)
                    }
                }
                .frame(width: 125, alignment: .leading)

                VStack(alignment: .trailing) {
                    if coin.priceChangePercentage24H ?? 0 > 0 {
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

                    if coin.priceChangePercentage24H ?? 0 < 0 {
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

                    if coin.priceChangePercentage24H ?? 0 == 0 {
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
                    Text("$\((coin.currentPrice ?? 0).formatted())")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .padding(.bottom, 2)

                    HStack {
                        Text("M.Cap")
                            .foregroundColor(.gray)
                            .font(.system(size: 8, weight: .regular, design: .rounded))

                        Text("$\(coin.marketCap ?? 0)")
                            .foregroundColor(.white)
                            .font(.system(size: 8, weight: .regular, design: .rounded))
                            .padding(.leading, -5)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
            .padding(.horizontal, 10)

            VStack {
                Text("Asset information")
                    .foregroundColor(.white)
                    .font(.system(size: 1, weight: .bold))
                    .opacity(0)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.ultraThinMaterial)
                .blur(radius: 0)
                .opacity(0.9)
        )
        .mask(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
        )
        .preferredColorScheme(.dark)
        
    }
}

struct BasicAssetInfoCardView_Previews: PreviewProvider {
    
    @Namespace static var animation
    @State static var name = ""
    @State static var marketCapRank = 2
    @State static var priceChangePercentage = 2.0
    
    static var previews: some View {
        BasicAssetInfoCardView(name: name, marketCapRank: marketCapRank, symbol: name, priceChangePercentage: priceChangePercentage, currentPrice: priceChangePercentage, marketCap: marketCapRank, imgURL: name, totalVolume: priceChangePercentage, high24H: priceChangePercentage, low24H: priceChangePercentage, maxSupply: priceChangePercentage, totalSupply: priceChangePercentage, circulatingSupply: priceChangePercentage, ath: priceChangePercentage, atl: priceChangePercentage, isTouched: .constant(false), isListVisible: .constant(false), animation: animation, coin: CoinsModel.init())
    }
}
