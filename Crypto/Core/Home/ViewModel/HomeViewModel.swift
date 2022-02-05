//
//  HomeViewModel.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{
    @Published var allCoins = [CoinModel] ()
    @Published var portfolioCoins = [CoinModel] ()
    private let dataService = CoinDataService()
    private var cancelables = Set<AnyCancellable>()
    
    init(){
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.allCoins.append(DeveloperPreview.instance.coin)
//            self.portfolioCoins.append(DeveloperPreview.instance.coin)
//        }
        addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$allCoins
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancelables)
    }
}
