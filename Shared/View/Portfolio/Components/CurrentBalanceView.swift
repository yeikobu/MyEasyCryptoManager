//
//  CurrentBalanceView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 30-03-22.
//

import SwiftUI
import SwiftUICharts

struct CurrentBalanceView: View {
    
    @StateObject var favouriteAssetViewModel: FavouriteAssetViewModel = FavouriteAssetViewModel()
    @Binding var currentBalanceUSD: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text("Current Balance")
                    .foregroundColor(.gray)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding(.bottom, -5)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("$\(String(format: "%.2f", favouriteAssetViewModel.currentBalance ?? 0))")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .black, design: .rounded))
                    
                    HStack {
                        HStack {
                            Text("Profit/Loss")
                                .foregroundColor(.gray)
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                            
                            Image(systemName: "arrowtriangle.up.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 8))
                                .padding(.trailing, -6)
                                .padding(.leading, -4)
                            
                            Text("$92,02")
                                .foregroundColor(.green)
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .padding(.leading, -4)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("24H Percentage:")
                                .foregroundColor(.gray)
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                            
                            Image(systemName: "arrowtriangle.up.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 8))
                                .padding(.trailing, -6)
                                .padding(.leading, -4)
                            
                            Text("5,2%")
                                .foregroundColor(.green)
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .padding(.leading, -4)
                        }
                    }
                    
//                    VStack(alignment: .center) {
//                        PieChartView(data: [20, 10, 10, 60], title: "Asset percentage", style: ChartStyle(backgroundColor: Color.black.opacity(0.2), accentColor: .red, gradientColor: GradientColor(start: Color.red, end: Color.green), textColor: .white, legendTextColor: .gray, dropShadowColor: .black), dropShadow: false)
//                        
//                    }
//                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .fill(.ultraThinMaterial)
                )
            }
            
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            Task {
                await self.favouriteAssetViewModel.calcCurrentBalance()
            }
            
        }
    }
}

struct CurrentBalanceView_Previews: PreviewProvider {
    
    @State static var currentPrice = 47000.2
    
    static var previews: some View {
        CurrentBalanceView(currentBalanceUSD: $currentPrice)
            .preferredColorScheme(.dark)
    }
}
