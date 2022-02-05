//
//  SearchBarView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText:String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondTextColor : .black)
            TextField("Search by name or symbol...", text: $searchText)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")  .padding()
                        .offset(x: 10, y: 0)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,
                    alignment: .trailing)
            
        }
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 50)
            .fill(Color(.systemGray6))
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
