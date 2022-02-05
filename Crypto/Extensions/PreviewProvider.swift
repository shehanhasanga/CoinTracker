//
//  PreviewProvider.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev : DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview{
    static let instance  = DeveloperPreview()
    
    static let homeViewModel = HomeViewModel()
    
    private init(){
        
    }
    
    let coin  = CoinModel(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 41634, marketCap: 788625948611, marketCapRank: 1, fullyDilutedValuation: 873976818356, totalVolume: 26168743639, high24H: 41839, low24H: 37482, priceChange24H: 4032.41, priceChangePercentage24H: 10.724, marketCapChange24H: 75046686629, marketCapChangePercentage24H: 10.51694, circulatingSupply: 18949181, totalSupply: 21000000, maxSupply: 21000000, ath: 69045, athChangePercentage: -39.81067, athDate: "2021-11-10T14:24:11.849Z", atl: 67.81, atlChangePercentage: 61186.24146, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2022-02-05T05:51:31.682Z", sparklineIn7D: SparklineIn7D(price: [37819.36313990765,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         37593.729428346,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         37573.643312332555,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         37794.06295491775]), priceChangePercentage24HInCurrency: 10.723997848394436, currentHolding: 1.5)
}
