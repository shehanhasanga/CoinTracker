//
//  CoinDataService.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import Foundation
import Combine

class CoinDataService{
    @Published var allCoins: [CoinModel] = []
    var coinCancelable : AnyCancellable?
    var cancelables = Set<AnyCancellable>()
    
    init(){
        getAllCoins()
    }
    
     func getAllCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=true&price_change_percentage=24h") else { return  }
        
        coinCancelable =  NetworkingManager.fetchCoins(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                NetworkingManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self]coins in
                self?.allCoins = coins
                self?.coinCancelable?.cancel()
                print("data loaded +++++++++")
            })
        
    }
}
