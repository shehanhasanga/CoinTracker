//
//  CoinImageViewModel.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel:ObservableObject{
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    
    private let coin:CoinModel
    private let dataService: CoinImageService
    private var cancelable = Set<AnyCancellable>()
    
    init(coin:CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubscription()
    }
    private func addSubscription(){
        dataService.$image
            .sink { [weak self]_ in
                self?.isLoading = false
            } receiveValue: { [weak self] imagenew in
                self?.image = imagenew
            }
            .store(in: &cancelable)

    }
}
