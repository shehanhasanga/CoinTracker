//
//  MarketDataModel.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-06.
//

import Foundation
import SwiftUI
struct GlobalData:Codable {
    let data: MarketDataModel?
}

// MARK: - DataClass
struct MarketDataModel :Codable{
   
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys : String, CodingKey{
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        
    }
    
    var marketCap : String {
        if let item = totalMarketCap.first(where: {(key, value) -> Bool in
            return key == "usd"
        }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume : String {
        if let item = totalVolume.first(where: {(key, value) -> Bool in
            return key == "usd"
        }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance : String {
        if let item = marketCapPercentage.first(where: {(key, value) -> Bool in
            return key == "btc"
        }) {
            return item.value.asPercentageString()
        }
        return ""
    }
}
