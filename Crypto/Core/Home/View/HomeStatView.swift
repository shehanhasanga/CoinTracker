//
//  HomeStatView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import SwiftUI

struct HomeStatView: View {
    @EnvironmentObject var homeViewModel:HomeViewModel
    @Binding var showPortfolio:Bool
    
    var body: some View {
        HStack{
            ForEach(homeViewModel.stats) { stat in
                StatisticView(stat: stat)
                    .frame(width:UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width:UIScreen.main.bounds.width
               , alignment: showPortfolio ? .trailing : .leading
        )
        
        
    }
}

struct HomeStatView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatView( showPortfolio: .constant(true))
            .environmentObject(DeveloperPreview.homeViewModel)
    }
}
