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
    @State var showDescription:Bool = false
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
                   
                    descriptionSection
                    
                    overviewGrid
                    
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                    websiteSection
                    
                  
                    
                    
                    
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
    
    var descriptionSection : some View{
        ZStack{
            if let coindescription = detailsViewModel.coinDescription, !coindescription.isEmpty{
                VStack(alignment:.leading){
                    Text(coindescription)
                        .lineLimit(showDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondTextColor)
                    Button{
                        withAnimation(.easeInOut) {
                            showDescription.toggle()
                        }
                    }label: {
                        Text(showDescription ? "Show Less" : "Read More..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(.horizontal,4)
                    }
                }
                
                
                
            }
        }
    }
    
    var websiteSection: some View{
        VStack(spacing:10){
            if let wesitestring = detailsViewModel.websiteUrl,
               let websiteURL = URL(string: wesitestring) {
                Link("Website", destination: websiteURL)
            }
            if let reditString = detailsViewModel.reditUrl,
               let reditUrl = URL(string: reditString){
                Link("Reddit", destination: reditUrl)
            }
        }
        .accentColor(.blue)
        .frame(alignment:.leading)
        .font(.headline)
    }
}
