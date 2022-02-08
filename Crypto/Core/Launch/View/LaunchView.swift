//
//  LaunchView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import SwiftUI

struct LaunchView: View {
    @State var loadingTxt : [String] = "Loading your portfolio ....".map {String($0)}
    @State var showLoading :Bool = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var counter :Int = 0
    @State var loops :Int = 0
    @Binding var showLaunchView :Bool
    var body: some View {
        ZStack{
            Color.launch.bacckground
                .ignoresSafeArea()
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100, alignment:.center)
            ZStack{
                
                if showLoading {
                    HStack(spacing:0){
                        ForEach(loadingTxt.indices) {index in
                            Text(loadingTxt[index])
                                .font(.headline)
                                .foregroundColor(Color.launch.accent)
                                .offset(y: counter == index ? -5 : 0 )
                               
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                    
                    
                   
                       
                }
               
            }
            .offset(y: 100)
        }
        .onAppear {
            showLoading.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation {
                let lastIndex = loadingTxt.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
              
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
