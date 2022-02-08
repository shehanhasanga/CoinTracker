//
//  CoinDetailDataService.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import Foundation
import Combine

class CoinDetailDataService{
    @Published var coinDetails: CoinDetailsModel? = nil
    let coin:CoinModel
    var coinCancelable : AnyCancellable?
    var cancelables = Set<AnyCancellable>()
    
    init(coin:CoinModel){
        self.coin = coin
        getAllCoinDetals()
    }
    
     func getAllCoinDetals(){
         let string = "https://api.coingecko.com/api/v3/coins/" + (coin.id ?? "") + "?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
         guard let url = URL(string: string) else { return  }
        
        coinCancelable =  NetworkingManager.fetchCoins(url: url)
            .decode(type: CoinDetailsModel.self, decoder: JSONDecoder())
            .receive(on:DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                NetworkingManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self]coindetail in
                self?.coinDetails = coindetail
                self?.coinCancelable?.cancel()
            })
        
    }
}
