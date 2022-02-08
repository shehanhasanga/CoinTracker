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
    @State var showLaunchView:Bool = true
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationView{
                    HomeView()
                        .navigationBarHidden(true)
                        
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(viewModel)
                ZStack{
                    if(showLaunchView){
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2)
               
                
                
            }
            
//            ContentView()
        }
    }
}
