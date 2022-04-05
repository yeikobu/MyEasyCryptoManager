//
//  UserAssetCard.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 30-03-22.
//

import SwiftUI
import CoreHaptics
import Kingfisher

struct UserAssetCardView: View {
    
    @ObservedObject var haptics: Haptics = Haptics()
    @State var name: String
    @State var symbol: String
    @State var priceChangePercentage: Double
    @State var currentPrice: Double
    @State var imgURL: String
    @State var purchaseQuantity: Double
    @State var quantityUSD: Double = 0
    var animation: Namespace.ID
    
    @State var addButtonAnimate: Bool = false
    @State var isAddedToPorfolio: Bool
    @Binding var isTouched: Bool
    
    let buttonAnimationDuration:  Double = 0.15
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack(alignment: .center) {
                    KFImage(URL(string: imgURL))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "icon", in: animation)
                        .frame(width: 40, height: 40)
                    
                    Text(name)
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .matchedGeometryEffect(id: "name", in: animation)
                        .padding(.bottom, -3)
                }
                
                Spacer()
                Spacer()
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("\(currentPrice.formatted())")
                        .matchedGeometryEffect(id: "currentPrice", in: animation)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .padding(.bottom, -4)
                    
                    VStack(alignment: .trailing) {
                        if priceChangePercentage > 0 {
                            HStack {
                                Image(systemName: "arrowtriangle.up.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 8))

                                Text("\(String(format: "%.2f", priceChangePercentage))%")
                                    .foregroundColor(.green)
                                    .font(.system(size: 10, weight: .bold, design: .rounded))
                                    .frame(alignment: .leading)
                                    .padding(.leading, -4)
                            }
                        }

                        if priceChangePercentage < 0 {
                            HStack {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 8))

                                Text("\(String(format: "%.2f", priceChangePercentage))%")
                                    .foregroundColor(.red)
                                    .font(.system(size: 10, weight: .bold, design: .rounded))
                                    .frame(alignment: .leading)
                                    .padding(.leading, -4)
                            }
                        }

                        if priceChangePercentage == 0 {
                            HStack {
                                Image(systemName: "arrowtriangle.right.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 8))

                                Text("\(String(format: "%.2f", priceChangePercentage))%")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10, weight: .bold, design: .rounded))
                                    .frame(alignment: .leading)
                                    .padding(.leading, -4)
                            }
                        }
                    }
                    .matchedGeometryEffect(id: "priceChangePercentage", in: animation)
                    .padding(.top, -4)
                }
                
                Spacer()
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(quantityUSD.formatted())")
                        .matchedGeometryEffect(id: "holdingPrice", in: animation)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .padding(.bottom, -4)
                    
                    Text("\(purchaseQuantity.formatted())")
                        .matchedGeometryEffect(id: "holdingcoins", in: animation)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .padding(.bottom, -4)
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    Button {
                        DispatchQueue.main.asyncAfter(deadline: .now() + buttonAnimationDuration) {
                            withAnimation(.spring(response: 0.6, dampingFraction: 1)) {
                                isTouched = true
                            }
                        }
                        
                        haptics.addFunctionVibration()
                        addButtonAnimate = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.spring(response: buttonAnimationDuration, dampingFraction: 1)) {
                                addButtonAnimate = false
                                isAddedToPorfolio = true
                            }
                        }
                    } label: {
                        VStack {
                            Image(systemName: "plus.app")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(Color("Buttons"))
                            
                            Text("Add more")
                                .foregroundColor(.gray)
                                .font(.system(size: 8))
                        }
                    }
                    .matchedGeometryEffect(id: "favorite", in: animation)
                    .padding(.leading, 5)
                    .scaleEffect(addButtonAnimate ? addButtonScale : 1)
                }
                .frame(width: 40)
            }
            .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
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
        .preferredColorScheme(.dark)
        .task {
            quantityUSD = currentPrice * purchaseQuantity
        }
        .onAppear {
            quantityUSD = currentPrice * purchaseQuantity
        }
    }
}

//struct UserAssetCardView_Previews: PreviewProvider {
//
//    @Namespace static var animation
//    @State static var name = "Bitcoin"
//    @State static var img = "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579"
//    @State static var currentPrice = 47000.2
//    @State static var marketCapRank = 2
//    @State static var priceChangePercentage = 2.0
//
//    static var previews: some View {
//        UserAssetCardView(name: $name, symbol: $name, priceChangePercentage: $priceChangePercentage, currentPrice: $currentPrice, imgURL: $img, animation: animation, addButtonAnimate: false, isAddedToPorfolio: false, isTouched: .constant(false))
//            .preferredColorScheme(.dark)
//    }
//}

