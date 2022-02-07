//
//  NewPortfolioView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import SwiftUI

struct NewPortfolioView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            ScrollView{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                XmarkButton()
            }
            .navigationTitle("new Portfolio")
                        .navigationBarItems(leading:
                                                Button{
                            dismiss()
                        } label: {
                            Text("btn")
                                
                        }
                        )
           
        }
       
    }
}

struct NewPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        NewPortfolioView()
    }
}
