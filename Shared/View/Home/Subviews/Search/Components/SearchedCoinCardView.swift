//
//  SearchedCoinCardView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 26-04-22.
//

import SwiftUI
import Kingfisher

struct SearchedCoinCardView: View {
    
    @State var name: String
    @State var marketCapRank: Int
    @State var symbol: String
    @State var imgURL: String
    @Binding var isTouched: Bool
    @Binding var isListVisible: Bool
    var animation: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack {
                    
                    Text("\(marketCapRank)")
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .frame(width: 50)
                        .padding(5)
                    
                    KFImage(URL(string: imgURL))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    
                    Text(name)
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .padding(.bottom, -3)
                    
                    Text(symbol.uppercased())
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .padding(.bottom, -3)
                }
                .frame(maxWidth: 320, alignment: .leading)
            }
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .blur(radius: 0)
                    .opacity(0.9)
            )
            .mask(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
            )
            .padding(.vertical, 2)
            .preferredColorScheme(.dark)
            
        }
        
    }
}

struct SearchedCoinCardView_Previews: PreviewProvider {
    
    @Namespace static var animation
    @State static var name = ""
    @State static var marketCapRank = 2
    @State static var priceChangePercentage = 2.0
    
    static var previews: some View {
        SearchedCoinCardView(name: dev.coin.name ?? "", marketCapRank: dev.coin.marketCapRank ?? 0, symbol: dev.coin.symbol ?? "", imgURL: dev.coin.image ?? "", isTouched: .constant(false), isListVisible: .constant(false), animation: animation)
    }
}
