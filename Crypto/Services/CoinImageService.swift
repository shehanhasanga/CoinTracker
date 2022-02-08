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
    private let localFileManger = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName:String
    
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id ?? ""
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedImage = localFileManger.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Get image from local file manager.")
        } else {
            downloadCoinImage()
            print("Download Image.")
        }
    }
    
    private func downloadCoinImage(){
        guard let url = URL(string: coin.image ?? "") else { return  }
        
        imageSubscription =  NetworkingManager.fetchCoins(url: url)
            .tryMap({(imageData) -> UIImage? in
                return UIImage(data: imageData)
            })
            .receive(on:DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                NetworkingManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self]returnedImage in
                guard let self = self else {return}
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.localFileManger.saveImage(image: returnedImage ?? UIImage(), imageName: self.imageName, folderName: self.folderName)
            })
    }
}
