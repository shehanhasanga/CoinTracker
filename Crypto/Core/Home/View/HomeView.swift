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
    @State var showHomeView =  false
    @State var showSettingsView =  false
    
    @State var selectedCoin:CoinModel? = nil
    @State var showDetailView:Bool = false
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
                    ZStack(alignment:.top){
                        if viewModel.portfolioCoins.isEmpty && viewModel.searchText.isEmpty {
                            Text("You have not added any coin to your pocket yet. Please add any coin from the list")
                                .font(.callout)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(50)
                        } else {
                            portfolioList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                
              
                Spacer()
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
        .background(
        NavigationLink(
            destination: DetailsLoadingView(coin: $selectedCoin),
            isActive: $showDetailView,
            label: {
               EmptyView()
            }
        )
        )
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
            HStack(spacing:4){
                Text("Coin")
                    .bold()
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: (viewModel.sortOption == .rank) ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
               
            }
           
            Spacer()
            if showPorfolio {
                HStack(spacing:4){
                    Text("Holdings")
                        .bold()
                    Image(systemName: "chevron.down")
                        .opacity( (viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: (viewModel.sortOption == .holdings) ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                   
                }
               
            }
           
            Spacer()
            HStack(spacing:4){
                Text("Price")
                    .bold()
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: (viewModel.sortOption == .price) ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
               
            }
            
          
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
//                NavigationLink {
//                    DetailsView(coin: coin)
//                } label: {
//                    CoinRowView(coin:coin, showHoldingColumn: false)
//                }
                CoinRowView(coin:coin, showHoldingColumn: false)
                    .onTapGesture {
                        segue(coin: coin)
                    }
               
                   
            }
            
        }
        .listStyle(PlainListStyle())
        .frame(alignment:.leading)
    }
    
    private func segue(coin:CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var portfolioList : some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin:coin, showHoldingColumn: true)
                    .onTapGesture {
                        segue(coin: coin)
                    }
                   
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
                    } else{
                        showSettingsView.toggle()
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
