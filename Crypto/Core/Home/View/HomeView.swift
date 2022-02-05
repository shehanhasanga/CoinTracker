//
//  HomeView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var showPorfolio = false
    var body: some View {
        
        ZStack{
            Color.theme.bacckground
                .ignoresSafeArea()
            VStack{
                homeHeader
                SearchBarView(searchText: $viewModel.searchText)
                columnTitles
                
                
                if !showPorfolio {
                    allCoinList
                    .transition(.move(edge: .leading))
                } else {
                    portfolioList
                    .transition(.move(edge: .trailing))
                }
                
              
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(DeveloperPreview.homeViewModel)
       
    }
}

extension HomeView {
    private var columnTitles : some View {
        HStack{
            Text("Coin")
                .bold()
            Spacer()
            if showPorfolio {
                Text("Holdings")
                    .bold()
            }
           
            Spacer()
            Text("Price")
                .bold()
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondTextColor)
        .padding(.horizontal)
    }
    private var allCoinList : some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin:coin, showHoldingColumn: false)
                   
            }
            
        }
        .listStyle(.plain)
    }
    private var portfolioList : some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin:coin, showHoldingColumn: false)
                   
            }
            
        }
        .listStyle(.plain)
    }
    private var homeHeader : some View {
        HStack{
            CircleButton(iconName: showPorfolio ? "plus":"info")
                .animation(.none)
                .background(
                CircleButtonAnimationView(animate: $showPorfolio)
                )
            Spacer()
            Text(showPorfolio ? "Portfolio" :"Live Prices ")
                .fontWeight(.heavy)
                .animation(.none)
            Spacer()
            CircleButton(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPorfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation {
                        showPorfolio.toggle()
                    }
                    
                }
        }
        .padding(.horizontal)
    }
}
