//
//  DetailViewModel.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject{
    
    @Published var overviewStats = [StatisticModel]()
    @Published var detailsStats = [StatisticModel]()
    @Published var coin:CoinModel
    
    private let coinDetailsDataService :CoinDetailDataService
    private var cancelables = Set<AnyCancellable>()
    
    
    init(coin:CoinModel) {
        self.coin = coin
        self.coinDetailsDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailsDataService.$coinDetails
            .combineLatest($coin)
            .map({ (coindetails, coindata) -> (overview:[StatisticModel], details:[StatisticModel]) in
               
                
                let price = coindata.currentPrice?.currencyWith6Decimals()
                let percentage =  coindata.priceChangePercentage24H
                let priceStat = StatisticModel(title: "Current Price", value: price ?? "", percentageChange: percentage)
                
                let marketCap = "$" + (coindata.marketCap?.formattedWithAbbreviations() ?? "")
                let marketCapChange = coindata.marketCapChangePercentage24H
                let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
                
                let rank = ".\(coindata.rank)"
                let rankStat = StatisticModel(title: "Rank", value: rank)
                
                let volume = "$" + (coindata.totalVolume?.formattedWithAbbreviations() ?? "")
                let volumeStat = StatisticModel(title: "Volume", value: volume)
                
                let overviewArray : [StatisticModel] = [
                    priceStat, marketCapStat, rankStat, volumeStat
                ]
                
                let high =  coindata.high24H?.currencyWith6Decimals() ?? "n/a"
                let highStat = StatisticModel(title: "24th High", value: high)
                
                let low =  coindata.low24H?.currencyWith6Decimals() ?? "n/a"
                let lowStat = StatisticModel(title: "24th Low", value: low)
                
                let pricechange =  coindata.priceChangePercentage24H?.currencyWith2Decimals() ?? "n/a"
                let pricechnage2 =  coindata.priceChangePercentage24H
                let pricechnag2Stat = StatisticModel(title: "24th Price Change", value: pricechange, percentageChange: pricechnage2)
                
                let marketChnage = "$" + (coindata.marketCapChange24H?.formattedWithAbbreviations() ?? "")
                let marketcappercentagechnage2 = coindata.marketCapChangePercentage24H
                let marketchnag2Stat = StatisticModel(title: "24th Market Cap Change", value: marketChnage, percentageChange:marketcappercentagechnage2)
                
                let blockTime = coindetails?.blockTimeInMinutes ?? 0
                let blockString = blockTime == 0 ? "n/a" : ".\(blockTime)"
                let blockStat = StatisticModel(title: "Block Time", value:blockString )
                
                let hashing = coindetails?.hashingAlgorithm ?? "n/a"
                let hashStat = StatisticModel(title: "Hashing Algorith", value: hashing )
                
                let additionalArray :[StatisticModel] = [
                    highStat, lowStat, pricechnag2Stat, marketchnag2Stat, blockStat, hashStat
                ]
                
                
                return (overviewArray,additionalArray)
            })
            .sink { [weak self]returnArrays in
                self?.overviewStats = returnArrays.overview
                self?.detailsStats = returnArrays.details
            }
            .store(in: &cancelables)
    }
    
}

