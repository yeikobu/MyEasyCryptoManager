//
//  AddAssetView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 25-03-22.
//

import SwiftUI

struct AddAssetView: View {
    
    @State var amount: String = ""
    @State var purcharsePrice: String = ""
    @Binding var isAddedToPorfolio: Bool
    var animation: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                
                HStack {
                    Text("Add bitcoin to portfolio")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .black, design: .rounded))
                }
                
                VStack(spacing: 15) {
                    //Quantity
                    VStack(alignment: .leading) {
                        Text("Amaunt of btc you want to add")
                            .foregroundColor(.white)
                            .font(.system(size: 11, design: .rounded))
                            .padding(.bottom, -5)
                        
                        HStack {
                            ZStack(alignment: .leading) {
                                if amount.isEmpty {
                                    Text("1")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                        .padding(.leading, 10)
                                }
                                
                                TextField("", text: $amount)
                                    .foregroundColor(.white)
                                    .keyboardType(.decimalPad)
                                    .font(.body)
                                    .padding(8)
                                    .padding(.leading, 2)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            }
                            
                            Text("BTC")
                                .foregroundColor(.white)
                                .font(.system(size: 12, design: .rounded))
                                .padding(.trailing, 10)
                        }
                        .background(Color("TextField"))
                        .cornerRadius(10)
                    }
                    
                    //Price per coin
                    VStack(alignment: .leading)  {
                        Text("Purchase price")
                            .foregroundColor(.white)
                            .font(.system(size: 11, design: .rounded))
                            .padding(.bottom, -5)
                        
                        HStack {
                            ZStack(alignment: .leading) {
                                if amount.isEmpty {
                                    Text("42000")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 12, design: .rounded))
                                        .padding(.leading, 10)
                                }
                                
                                TextField("", text: $amount)
                                    .foregroundColor(.white)
                                    .keyboardType(.decimalPad)
                                    .font(.body)
                                    .padding(8)
                                    .padding(.leading, 2)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            }
                            
                            Text("USD")
                                .foregroundColor(.white)
                                .font(.system(size: 12, design: .rounded))
                                .padding(.trailing, 10)
                        }
                        .background(Color("TextField"))
                        .cornerRadius(10)
                        
                    }
                    
                    Button {
                        //
                    } label: {
                        Text("Add")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding()
                            .frame(width: 120, height: 40)
                            .background(.yellow)
                            .cornerRadius(15)
                            .shadow(color: Color(.black).opacity(0.8), radius: 6, x: 4, y: 4)
                            .shadow(color: Color(.black).opacity(0.8), radius: 6, x: -4, y: -4)
                    }
                    .padding(.top)

                        
                }
                .padding(.vertical, 10)
            }
            .padding(10)
            .background(Color("Card"))
            .cornerRadius(10)
            .padding(10)
            .shadow(color: .black.opacity(0.7), radius: 6, x: 4, y: 4)
            .shadow(color: .black.opacity(0.7), radius: 6, x: -4, y: -4)
            
            Button {
                withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                    isAddedToPorfolio = false
                }
            } label: {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundColor(Color("TabButtonsColor"))
                    .font(.system(size: 18, weight: .black, design: .rounded))
                
            }
            .padding(20)
            
        }
        .frame(maxWidth: isAddedToPorfolio ? .infinity : 1, maxHeight: isAddedToPorfolio ? .infinity : 1)
    }
}

struct AddAssetView_Previews: PreviewProvider {
    
    @Namespace static var animation
    
    static var previews: some View {
        AddAssetView(isAddedToPorfolio: .constant(true), animation: animation)
            .preferredColorScheme(.light)
    }
}
