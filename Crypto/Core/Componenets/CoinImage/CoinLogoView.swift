//
//  CoinLogoView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-06.
//

import SwiftUI

struct CoinLogoView: View {
    let coin:CoinModel
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol?.uppercased() ?? "")
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name ?? "")
                .font(.caption)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
            
        }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin)
    }
}
