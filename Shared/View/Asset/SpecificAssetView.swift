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
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                
                AssetView(imgURL: "", name: "Bitcoin", marketCapRank: 1, symbol: "BTC", isTouched: .constant(false), isAddedToPorfolio: .constant(false), isListVisible: .constant(false))
                
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .padding(.bottom, 10)
                    .padding(.horizontal, 5)
            }
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
            .navigationBarBackButtonHidden(true)
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
    
    @Binding var isTouched: Bool
    @Binding var isAddedToPorfolio: Bool
    @State var addButtonAnimate: Bool = false
    @Binding var isListVisible: Bool
    var addButtonScale: CGFloat {
        isTouched ? 1.5 : 0.8
    }
    let buttonAnimationDuration:  Double = 0.15
    
    var body: some View {
        ScrollView {
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
                        .font(.system(size: 9, weight: .bold, design: .rounded))
                        .padding(5)
                    
                    Text(name)
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        
                    Text(symbol.uppercased())
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
                        .padding(.leading, 5)
                        .scaleEffect(addButtonAnimate ? addButtonScale : 1)
                        .offset(x: isListVisible ? 0 : 200, y: 0)
                    }
                    .frame(width: 40)
                    
                    
                }
                .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
                .padding(.horizontal, 10)
                
                
            }
        }
        .onAppear {
            specificCoinViewModel.getSpecificCoin(selectedCoin: self.name.lowercased())
            print(specificCoinViewModel.specificCoinModel)
            print(self.name)
        }
    }
}

struct SpecificAssetView_Previews: PreviewProvider {
    
    @State static var name: String = "bitcoin"
    
    static var previews: some View {
        SpecificAssetView(name: $name)
    }
}
