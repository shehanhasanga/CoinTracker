//
//  DetailsView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import SwiftUI

struct DetailsLoadingView: View {
    @Binding var coin:CoinModel?
    init(coin:Binding<CoinModel?>){
        self._coin = coin
        print("created view for \(coin.wrappedValue?.name)")
    }
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailsView(coin:coin)
            }
        }
        
    }
}


struct DetailsView: View {
    @StateObject var detailsViewModel:DetailViewModel
    var coin:CoinModel
    init(coin: CoinModel){
        self.coin = coin
        _detailsViewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text(coin.name ?? "")
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(coin: dev.coin )
    }
}
