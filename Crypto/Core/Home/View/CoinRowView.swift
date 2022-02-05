//
//  CoinRowView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin :CoinModel
    let showHoldingColumn :Bool
    var body: some View {
        HStack{
            leftColumn
            Spacer()
            if(showHoldingColumn) {
                centerColumn
            }
            rightColumn
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingColumn: true)
    }
    
    
}

extension CoinRowView {
    private var leftColumn: some View{
        HStack(spacing:0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondTextColor)
                .frame(minWidth:30)
            CoinImageView(coin: coin)
                .frame(width:30,height: 30)
            Text(coin.symbol?.uppercased() ?? "")
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(.black)
        }
    }
    
    private var centerColumn: some View{
        VStack(alignment:.trailing){
            Text(coin.currenHoldingValue.currencyWith2Decimals())
                .bold()
            Text((coin.currentHolding ?? 0).asNumerToString())
        }
        .foregroundColor(.black)
    }
    private var rightColumn: some View{
        VStack(alignment:.trailing){
            Text(coin.currentPrice?.currencyWith6Decimals() ?? "")
                .bold()
                .foregroundColor(.black)
            Text("\((coin.priceChangePercentage24H ?? 0).asPercentageString())")
                .foregroundColor(
                    coin.priceChangePercentage24H ?? 0 >= 0 ? .green : .red
                )
        }
    }
}
