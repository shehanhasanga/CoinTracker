//
//  ContentView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.greencolor
                .ignoresSafeArea()
        }
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
