//
//  ChartWithSpecificAssetModelView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 01-05-22.
//

import SwiftUI

struct ChartWithSpecificAssetModelView: View {
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    @Namespace var animation
    
    init(coin: SpecificCoinModel) {
        data = coin.marketData?.sparkline7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange >= 0 ? Color.green : Color.red
        
        endingDate = Date(apiCoinString: coin.marketData?.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(7*24*60*60) //7days * 24hours * 60minutes * 60 seconds
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 150)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal, 5), alignment: .leading)
            
            chartShortDatesStrings
                .padding(.horizontal, 5)
        }
        .font(.system(size: 9))
        .foregroundColor(Color.gray)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.6, dampingFraction: 1)) {
                    percentage = 1.0
                }
            }
        }
    }
}

//struct ChartWithSpecificAssetModelView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartWithSpecificAssetModelView()
//    }
//}


extension ChartWithSpecificAssetModelView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = ( 1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
            .matchedGeometryEffect(id: "line", in: animation)
            .shadow(color: lineColor, radius: 4, x: 2, y: 4)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
                .frame(height: 0.5)
            Spacer()
            Divider()
                .frame(height: 0.5)
            Spacer()
            Divider()
                .frame(height: 0.5)
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formatted())
            Spacer()
            Text(((maxY + minY) / 2).formatted())
            Spacer()
            Text(minY.formatted())
        }
    }
    
    private var chartShortDatesStrings: some View {
        HStack {
            Text(endingDate.asShortDateString())
            Spacer()
            Text(startingDate.asShortDateString())
        }
    }
}
