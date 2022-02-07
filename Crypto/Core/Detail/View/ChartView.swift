//
//  ChartView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import SwiftUI

struct ChartView: View {
    let data :[Double]
    let maxY:Double
    let minY :Double
    let lineColor:Color
    let startDate:Date
    let endDaate : Date
    
    @State var percentage:CGFloat = 0
    init(coin:CoinModel){
        data = coin.sparklineIn7D?.price ?? []
        minY = data.min() ?? 0
        maxY = data.max() ?? 0
        let priceChange = (data.last ?? 0 ) - (data.first ?? 0)
        lineColor = priceChange > 0 ? .green : .red
        
        endDaate = Date(coinGekoString: coin.lastUpdated ?? "")
        startDate = endDaate.addingTimeInterval(-7*24*60*60)
        
    }
    var body: some View {
        VStack{
            chartView
                .frame(height:200)
                .background {
                    chartBackGround
                }
                .overlay (alignment:.leading){
                    chartYlabels.padding(.horizontal,4)
                }
            chartXlabels.padding(.horizontal,4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondTextColor)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 1)) {
                    percentage = 1.0
                }
            }
        }
        
        
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView {
    var chartView : some View{
        GeometryReader{ geometry in
            Path{ path in
                for index in data.indices{
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxix = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxix)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: 0, y: 0))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 20, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 30, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 40, x: 0, y: 40)
        }
    }
    
    var chartBackGround : some View{
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    var chartYlabels : some View{
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    var chartXlabels : some View{
        HStack{
            Text(startDate.asShortDateString())
            Spacer()
            Text(endDaate.asShortDateString())
        }
    }
}
