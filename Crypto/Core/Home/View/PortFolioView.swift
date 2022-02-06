//
//  PortFolioView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-06.
//

import SwiftUI

struct PortFolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel:HomeViewModel
    @State var selectedCoin : CoinModel? = nil
    @State var quantityTxt : String = ""
    @State var showCheckMark : Bool = false
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment:.leading, spacing: 0){
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            
            .navigationTitle(Text("Edit Portfolio"))
            .navigationBarItems(leading:
                                    XmarkButton()
                                        .onTapGesture {
                                            presentationMode.wrappedValue.dismiss()
                                        }
            )
//            .toolbar(content: {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    XmarkButton()
//                        .onTapGesture {
//                            presentationMode.wrappedValue.dismiss()
//                        }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    trailingNavBarButtons
//                }
//            })
        }
       
    }
    
    private func getCurrentValue() -> Double {
        if let amount = Double(quantityTxt) {
            return amount * (selectedCoin?.currentPrice ?? 0)
        } else {
            return 0
        }
    }
}



struct PortFolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortFolioView()
            .environmentObject(DeveloperPreview.homeViewModel)
    }
}

extension PortFolioView {
    var coinLogoList : some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHStack(spacing:30){
                ForEach(viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width:75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10).stroke(selectedCoin?.id == coin.id ? .green : .clear, lineWidth: 2)
                                .shadow(color: selectedCoin?.id == coin.id ? .green : .clear, radius: 10, x: 0, y: 0)
                        )
                        
                }
            }
            .padding(.vertical, 10)
            .padding(.leading)
        }
    }
    
    var portfolioInputSection : some View {
        VStack(spacing:20){
            HStack{
                Text("The current price of \(selectedCoin?.symbol?.uppercased() ?? "") :")
                Spacer()
                Text("\(selectedCoin?.currentPrice?.asNumerToString() ?? "")")
            }
            Divider()
            
            HStack{
                Text("Amount holding")
                Spacer()
                TextField("Ex: 1.4", text: $quantityTxt)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            
            HStack{
                Text("Current value :")
                Spacer()
                Text(getCurrentValue().currencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
        .padding(.vertical, 20)
    }
    
    var trailingNavBarButtons : some View {
        HStack{
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1 : 0)
            Button{
                
            }label: {
                Text("Save".uppercased())
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHolding != Double(quantityTxt) ? 1 : 0)
          
        }
        .font(.headline)
    }
    
    private func saveBtnClicked(){
        guard let coin = selectedCoin else {return}
        withAnimation(.easeIn) {
            showCheckMark = true
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    func removeSelection(){
        selectedCoin = nil
        viewModel.searchText = ""
    }
}
