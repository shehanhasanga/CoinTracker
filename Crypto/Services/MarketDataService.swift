//
//  MarketDataService.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-06.
//

import Foundation
import Combine

class MarketDataService{
    @Published var marketData: MarketDataModel? = nil
    var marketDataCancelable : AnyCancellable?
//    var cancelables = Set<AnyCancellable>()
    
    init(){
        getmarketData()
    }
    
    private func getmarketData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return  }
        
        marketDataCancelable =  NetworkingManager.fetchCoins(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                NetworkingManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self]globaldata in
                self?.marketData = globaldata.data
                self?.marketDataCancelable?.cancel()
            })
        
    }
}

