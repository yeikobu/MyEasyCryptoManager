//
//  SearchView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 26-04-22.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var searchCoinViewModel: SearchCoinViewModel = SearchCoinViewModel()
    @StateObject var specificCoinViewModel: SpecificCoinViewModel = SpecificCoinViewModel()
    @State var text: String = ""
    @State var isTouched: Bool = false
    @State var isMoreInfoClicked: Bool = false
    @State var isListVisible: Bool = false
    @State var isAddedToPorfolio: Bool = false
    @State var addButtonAnimate: Bool = false
    @State var coinsAppear: Bool = false
    @State var totalResults: Int = 0
    @Namespace var animation
    @State var id: String = ""
    @State var imgURL: String = ""
    @State var name: String = ""
    @State var marketCapRank: Int = 0
    @State var symbol: String = ""
    @State var coin: SpecificCoinModel?
    
    let gridForm = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if !isTouched {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Search coins")
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .black, design: .rounded))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    
                    // MARK: - SearchBar
                    HStack {
                        Button {
                            withAnimation(.spring()) {
                                searchCoinViewModel.getCoins(searchedCoin: self.text)
                                self.coinsAppear = true
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(self.text.isEmpty ? .gray : Color("Buttons"))
                                .font(.system(size: 20, design: .rounded))
                        }
                        
                        ZStack(alignment: .leading) {
                            if self.text.isEmpty {
                                Text("Ex: Bitcoin, Ethereum")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, design: .rounded))
                                    .padding(.leading, 5)
                            }
                            
                            TextField("", text: $text) {(_) in } onCommit: {
                                withAnimation(.spring()) {
                                    searchCoinViewModel.getCoins(searchedCoin: self.text)
                                    self.coinsAppear = true
                                }
                            }
                            .foregroundColor(.white)
                            .disableAutocorrection(true)
                        }
                        
                        Button {
                            withAnimation(.spring()) {
                                withAnimation(.spring()) {
                                    self.text = ""
                                    self.coinsAppear = false
                                }
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(text.isEmpty ? .gray : Color("Buttons"))
                                .font(.system(size: 20, design: .rounded))
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 50, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .blur(radius: 0)
                            .opacity(0.7)
                    )
                    .padding(.horizontal, 10)
                    
                    if !coinsAppear {
                        
                        Spacer()
                        
                        VStack(alignment: .center) {
                            Text("No results")
                                .matchedGeometryEffect(id: "resultText", in: animation)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .padding(.bottom, 60)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        Spacer()
                    }
                    
                    
                    // MARK: - Searched results
                    if coinsAppear {
                        VStack(alignment: .leading) {
                            Text("Results: \(totalResults)")
                                .matchedGeometryEffect(id: "resultText", in: animation)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .padding(.leading, 10)
                                
                            
                            Divider()
                                .matchedGeometryEffect(id: "divider", in: animation)
                                .background(.gray)
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 15)
                        
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: gridForm) {
                                ForEach(searchCoinViewModel.searchCoinModel?.coins ?? [] , id: \.self) { asset in
                                    SearchedCoinCardView(name: asset?.name ?? "", marketCapRank: asset?.marketCapRank ?? 0, symbol: asset?.symbol ?? "", imgURL: asset?.large ?? "", isTouched: $isTouched, isListVisible: $isListVisible, animation: animation)
                                        .task {
                                            self.totalResults = searchCoinViewModel.searchCoinModel?.coins.count ?? 0
                                        }
                                        .onTapGesture {
                                            if let id = asset?.id {
                                                self.id = id
                                            }
                                            if let imgUrl = asset?.large {
                                                self.imgURL = imgUrl
                                            }
                                            if let name = asset?.name {
                                                self.name = name
                                            }
                                            if let marketCapRank = asset?.marketCapRank {
                                                self.marketCapRank = marketCapRank
                                            }
                                            if let symbol = asset?.symbol {
                                                self.symbol = symbol
                                            }
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                                                self.isTouched.toggle()
                                            }
                                            withAnimation(.spring(response: 0.6, dampingFraction: 1)) {
                                                self.isListVisible.toggle()
                                            }
                                        }
                                        .matchedGeometryEffect(id: "\(String(describing: asset?.id))" , in: animation)
                                        .offset(x: coinsAppear ? 0 : -100, y: coinsAppear ? 0 : 1000)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
            
            if isTouched {
                ZStack(alignment: .topTrailing) {
                    SpecificAssetView(favouriteAssetViewModel: FavouriteAssetViewModel(), imgURL: self.$imgURL, name: self.$name, marketCapRank: self.$marketCapRank, symbol: self.$symbol, coin: CoinsModel.init(), id: self.$id, isMoreInfoClicked: self.$isMoreInfoClicked, isAddedToPorfolio: self.isAddedToPorfolio, isTouched: self.$isTouched, isListVisible: self.$isListVisible, animation: animation)
                        .padding(.horizontal, 10)
                        .padding(.top, 30)
                        .padding(.bottom, 45)
                    
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            self.isTouched.toggle()
                        }
                        withAnimation(.spring(response: 0.5, dampingFraction: 1)) {
                            self.isListVisible.toggle()
                        }
                    } label: {
                        Image(systemName: "x.circle")
                            .foregroundColor(Color("Buttons"))
                            .font(.system(size: 22))
                            .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                            .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                    }
                    .padding(.trailing, 10)
                    
                }
                .matchedGeometryEffect(id: "\(self.id)", in: animation)
                .transition(.scale)
               
                Spacer()
            }
        }
        .frame(maxHeight: .infinity)
        .preferredColorScheme(.dark)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(coin: SpecificCoinModel.init())
    }
}
