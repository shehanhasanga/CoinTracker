//
//  CoinImageView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import SwiftUI



struct CoinImageView: View {
    @StateObject var viewModel: CoinImageViewModel
    init(coin:CoinModel){
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack{
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading{
                ProgressView()
            } else{
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondTextColor)
            }
        }
        
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
