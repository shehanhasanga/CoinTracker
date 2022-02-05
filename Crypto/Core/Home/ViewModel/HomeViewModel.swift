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
    
    @Published var searchText:String = ""
    init(){
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.allCoins.append(DeveloperPreview.instance.coin)
//            self.portfolioCoins.append(DeveloperPreview.instance.coin)
//        }
        addSubscribers()
    }
    
    func addSubscribers(){
        
//        dataService.$allCoins
//            .sink { [weak self] coins in
//                self?.allCoins = coins
//            }
//            .store(in: &cancelables)
        
        $searchText.combineLatest(dataService.$allCoins)
            .map { (searchOut, coinsOut) -> [CoinModel] in
                guard !searchOut.isEmpty else {
                    return coinsOut
                }
                let lowercaseSearchtxt = searchOut.lowercased()
                let filterset = coinsOut.filter{ coin -> Bool in
                    return coin.name?.lowercased().contains(lowercaseSearchtxt) ?? false ||
                    coin.symbol?.lowercased().contains(lowercaseSearchtxt) ?? false ||
                    coin.id?.lowercased().contains(lowercaseSearchtxt) ?? false
                }
                return filterset
            }
            .sink { [weak self]coins in
                self?.allCoins = coins
            }
            .store(in: &cancelables)
    }
}
