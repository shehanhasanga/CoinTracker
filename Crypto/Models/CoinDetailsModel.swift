//
//  CoinDetailsModel.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import Foundation
import SwiftUI

//https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false


//struct CoinDetailsModel: Codable {
//    let id,symbol,name: String?
//    let blockTimeInMinutes: Int?
//    let hashingAlgorithm: String?
//    let categories: [String]?
//    let description: Description?
//    let links: Links?
//
//    enum CodingKeys: String, CodingKey {
//        case id,symbol,name,description,links
//        case blockTimeInMinutes = "block_time_in_minutes"
//        case hashingAlgorithm = "hashing_algorithm"
//    }
//
//}
//
struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?

    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}
//
struct Description : Codable{
    let en: String?
}



struct CoinDetailsModel:Codable {
    let id,symbol,name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    enum CodingKeys: String, CodingKey {
        case id,symbol,name,description,links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
    
    var readableDescription : String {
        return description?.en?.removingHTMLOccurances ?? ""
    }
}


//struct Links:Codable {
//    let homepage: [String]?
//    let subredditURL: String?
//}
//
//struct Description :Codable {
//    let en: String?
//}
