//
//  CryptoApp.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import SwiftUI

@main
struct CryptoApp: App {
    @StateObject var viewModel  = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
//            ContentView()
        }
    }
}
