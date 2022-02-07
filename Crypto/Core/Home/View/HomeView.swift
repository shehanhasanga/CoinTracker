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
    @State private var showPorfolioView = false
    var body: some View {
        
        ZStack(alignment:.leading){
            Color.theme.bacckground
                .ignoresSafeArea()
                .sheet(isPresented: $showPorfolioView) {
                    PortFolioView()
                        .environmentObject(viewModel)
                }
            VStack{
                homeHeader
                HomeStatView(showPortfolio: $showPorfolio)
//                if !showPorfolio {
//                    HomeStatView(showPortfolio: $showPorfolio)
//                        .transition(.move(edge: .leading))
//                } else {
//                    HomeStatView(showPortfolio: $showPorfolio)
//                        .transition(.move(edge: .trailing))
//                }
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
            Button {
                withAnimation(.linear) {
                    viewModel.reloadData()
                }
            }label: {
                Image(systemName: "goforward")
                    .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0 ), anchor: .center)
            }
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
        .listStyle(PlainListStyle())
        .frame(alignment:.leading)
    }
    private var portfolioList : some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin:coin, showHoldingColumn: true)
                   
            }
            
        }
        .listStyle(PlainListStyle())
    }
    private var homeHeader : some View {
        HStack{
            CircleButton(iconName: showPorfolio ? "plus":"info")
                .onTapGesture {
                    if showPorfolio {
                        showPorfolioView.toggle()
                    }
                }
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
                    withAnimation(.spring()) {
                        showPorfolio.toggle()
                    }
                    
                }
        }
        .padding(.horizontal)
    }
}
