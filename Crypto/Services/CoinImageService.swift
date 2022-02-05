//
//  CoinImageService.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import Foundation
import UIKit
import Combine

class CoinImageService{
    @Published var image : UIImage? = nil
    var imageSubscription : AnyCancellable?
    private var coin:CoinModel
    
    
    init(coin: CoinModel){
        self.coin = coin
        getImage()
    }
    private func getImage(){
        guard let url = URL(string: coin.image ?? "") else { return  }
        
        imageSubscription =  NetworkingManager.fetchCoins(url: url)
            .tryMap({(imageData) -> UIImage? in
                return UIImage(data: imageData)
            })
            .sink(receiveCompletion: { completion in
                NetworkingManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self]image in
                self?.image = image
                self?.imageSubscription?.cancel()
            })
    }
}
