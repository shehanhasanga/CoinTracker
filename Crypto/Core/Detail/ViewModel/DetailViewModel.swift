//
//  DetailViewModel.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject{
    
    private let coinDetailsDataService :CoinDetailDataService
    private var cancelables = Set<AnyCancellable>()
    
    init(coin:CoinModel) {
        self.coinDetailsDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailsDataService.$coinDetails
            .sink { coindetails in
                
            }
            .store(in: &cancelables)
    }
    
}

