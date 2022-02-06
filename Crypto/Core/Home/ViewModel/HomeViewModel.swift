//
//  HomeViewModel.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{
    
    @Published var stats : [StatisticModel] = []
    
    @Published var allCoins = [CoinModel] ()
    @Published var portfolioCoins = [CoinModel] ()
    
    
    private let dataService = CoinDataService()
    private let marketDataService = MarketDataService()
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
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map (filterCoins)
            .sink { [weak self]coins in
                self?.allCoins = coins
            }
            .store(in: &cancelables)
        
        marketDataService.$marketData
            .map (mapGlobalData)
            .sink { [weak self]stats in
                self?.stats = stats
                
            }
            .store(in: &cancelables)
        
    }
    
    private func filterCoins(searchOut:String, coinsOut:[CoinModel]) -> [CoinModel] {
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
    
    private func mapGlobalData(marketData:MarketDataModel?) -> [StatisticModel] {
        var stats : [StatisticModel] = []
        guard let data = marketData else {
            return stats
        }
        
        let marketcap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        stats.append(marketcap)
        
        let volume = StatisticModel(title: "24th volume", value: data.volume)
        stats.append(volume)
        
        let btcdominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        stats.append(btcdominance)
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        stats.append(portfolio)
        return stats
    }
}
