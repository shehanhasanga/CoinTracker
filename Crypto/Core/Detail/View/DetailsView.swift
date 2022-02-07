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
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    
    ]
    private var grigSpacing = 30.0
    var coin:CoinModel
    init(coin: CoinModel){
        self.coin = coin
        _detailsViewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView{
            VStack{
                ChartView(coin: coin)
                    .padding(.vertical)
                VStack(alignment:.leading, spacing:20){
                    overviewTitle
                    Divider()
                    overviewGrid
                    
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                    
                }
                .padding()
            }
            
        }
        .navigationBarHidden(false)
        .navigationTitle(coin.name ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navbarTrailing
            }
        }
      
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailsView(coin: dev.coin )
        }
        
    }
}

extension DetailsView {
    var navbarTrailing : some View {
        HStack{
            Text(coin.symbol?.uppercased() ?? "")
                .font(.title)
                .foregroundColor(Color.theme.secondTextColor)
            CoinImageView(coin: coin)
                .frame(width: 25, height: 25)
        }
    }
    var overviewTitle : some View {
        Text("Overview")
            .font(.title)
            .bold()
            .frame( alignment: .leading)
    }
    
    var additionalTitle : some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .frame( alignment: .leading)
    }
    
    var overviewGrid : some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: grigSpacing, pinnedViews: []) {
            ForEach(detailsViewModel.overviewStats) {stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    var additionalGrid : some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: grigSpacing, pinnedViews: []) {
            ForEach(detailsViewModel.detailsStats) {stat in
                StatisticView(stat: stat)
            }
        }
    }
}
