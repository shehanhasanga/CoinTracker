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
    @Published var isLoading:Bool = false
    @Published var sortOption:SortOption = .holdings
    
    private let dataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancelables = Set<AnyCancellable>()
    
    @Published var searchText:String = ""
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
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
        
        $searchText.combineLatest(dataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map (filterAndSortCoins)
            .sink { [weak self]coins in
                self?.allCoins = coins
            }
            .store(in: &cancelables)
        
        marketDataService.$marketData.combineLatest($portfolioCoins)
            .map (mapGlobalData)
            .sink { [weak self]stats in
                self?.stats = stats
                self?.isLoading = false
                
            }
            .store(in: &cancelables)
        
        $allCoins.combineLatest(portfolioDataService.$savedPortfolio)
            .map (mapCoinsToPortFolioCoins)
            .sink { [weak self]coinsSaved in
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfolioCoins(coins: coinsSaved, sortOption: self.sortOption)
            }
            .store(in: &cancelables)
        
    }
    
    func mapCoinsToPortFolioCoins(coinmodels: [CoinModel], portfolioEntities : [PortfolioEntity]) -> [CoinModel]{
        coinmodels.compactMap({ coinmodel -> CoinModel? in
            guard let entity = portfolioEntities.first(where: {$0.coinID == coinmodel.id}) else {return nil}
            return coinmodel.updateHoldings(amount: entity.amount)
        })
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataService.updatePortFoilioData(coin: coin, amount: amount)
    }
    
    func reloadData(){
        isLoading = true
        dataService.getAllCoins()
        marketDataService.getmarketData()
        HapticManager.notification(type: .success)
        
    }
    
    private func filterAndSortCoins(searchOut:String, coinsOut:[CoinModel], sortOption: SortOption) -> [CoinModel] {
        var filerCoins = filterCoins(searchOut: searchOut, coinsOut: coinsOut)
        sortCoins(coins: &filerCoins, sortOption: sortOption)
        return filerCoins
    }
    
    private func sortPortfolioCoins(coins:[CoinModel], sortOption: SortOption) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHolding ?? 0 < $1.currentHolding ?? 0})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHolding  ?? 0 > $1.currentHolding ?? 0})

        default:
            return coins
        }
    }
    
    private func sortCoins(coins: inout[CoinModel], sortOption: SortOption)  {
        switch sortOption {
        case .rank, .holdings:
             coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
             coins.sort(by: {$0.rank > $1.rank})
        case .price:
             coins.sort(by: {($0.currentPrice ?? 0) < $1.currentPrice ?? 0})
        case .priceReversed:
             coins.sort(by: {($0.currentPrice ?? 0) > $1.currentPrice ?? 0})
        }
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
    
    private func mapGlobalData(marketData:MarketDataModel?, portfolioCoins:[CoinModel]) -> [StatisticModel] {
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
        
        let portfolioValue = portfolioCoins.map { coin -> Double in
            coin.currenHoldingValue
        }
        .reduce(0, +)
        
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currenHoldingValue
            let percentage = coin.priceChangePercentage24H ?? 0 / 100
            let previousvalue = currentValue / (1 + percentage)
            return previousvalue
            
        }
        .reduce(0, +)
        
        let percentagechnage = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.currencyWith2Decimals(), percentageChange: percentagechnage )
        stats.append(portfolio)
        return stats
    }
}
