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
                HStack {
                    KFImage(URL(string: imgURL))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "icon", in: animation)
                        .frame(width: 40, height: 40)

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
                    Text("$\(currentPrice.formatted())")
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
            }
            .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
            .padding(.horizontal, 10)

            VStack {
                Text("Asset information")
                    .matchedGeometryEffect(id: "information", in: animation)
                    .foregroundColor(.white)
                    .font(.system(size: 1, weight: .bold))
                    .opacity(0)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .matchedGeometryEffect(id: "assetInformation", in: animation)
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
        .preferredColorScheme(.dark)
    }
}

struct BasicAssetInfoCardView_Previews: PreviewProvider {
    
    @Namespace static var animation
    @State static var name = ""
    @State static var marketCapRank = 2
    @State static var priceChangePercentage = 2.0
    
    static var previews: some View {
        BasicAssetInfoCardView(name: $name, marketCapRank: $marketCapRank, symbol: $name, priceChangePercentage: $priceChangePercentage, currentPrice: $priceChangePercentage, marketCap: $marketCapRank, imgURL: $name, totalVolume: $priceChangePercentage, high24H: $priceChangePercentage, low24H: $priceChangePercentage, maxSupply: $priceChangePercentage, totalSupply: $priceChangePercentage, circulatingSupply: $priceChangePercentage, ath: $priceChangePercentage, atl: $priceChangePercentage, isTouched: .constant(false), isListVisible: .constant(false), animation: animation)
    }
}
