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
        ZStack {
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
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                    .blur(radius: 0)
                                    .opacity(0.7)
                            )
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
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                    .blur(radius: 0)
                                    .opacity(0.7)
                            )
                            
                        }

                    }
                    .padding(.vertical, 10)
                    .padding(.bottom, 20)
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
                .padding(10)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
                
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                        isAddedToPorfolio = false
                    }
                } label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(Color("Buttons"))
                        .opacity(0.85)
                        .font(.system(size: 18, weight: .black, design: .rounded))
                    
                }
                .padding(20)
                
            }
            
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                    isAddedToPorfolio = false
                }
            } label: {
                Text("Add")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding()
                    .frame(maxWidth: 250)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color("Buttons").opacity(0.85), Color("Buttons").opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .padding(.horizontal, 30)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 3, y: 3)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: -3, y: -3)
            }
            .padding(.top, 220)
        }
        .frame(maxHeight: .infinity)
        
    }
}

struct AddAssetView_Previews: PreviewProvider {
    
    @Namespace static var animation
    
    static var previews: some View {
        AddAssetView(isAddedToPorfolio: .constant(true), animation: animation)
            .preferredColorScheme(.light)
    }
}
