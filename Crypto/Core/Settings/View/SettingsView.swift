//
//  SettingsView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import SwiftUI

struct SettingsView: View {
    let defaultUrl = URL(string: "http://www.google.com")!
    let youtubeUrl = URL(string: "https://www.youtube.com/c/swiftfulthink")!
    let coingekkoUrl = URL(string: "https://www.coingecko.com/")!
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            List{
                headerSection
                coingekkoSection
                developerSection
                applicationSection
            }
            .listStyle(GroupedListStyle())
            .accentColor(.blue)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
        
    }
}

extension SettingsView {
    var headerSection: some View{
        Section {
            VStack(alignment:.leading){
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This is a crypto App. It is followed with the swift ui with mvvm architecture. It is powered by coingekko api for the crypto data.")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical, 10)
            
            Link("Youtube 📽", destination: youtubeUrl)
            Link("MySite 🔗", destination: youtubeUrl )
            
        } header: {
            Text("Swiftful Thinking")
        } footer: {
        }
    }
    
    var coingekkoSection: some View{
        Section {
            VStack(alignment:.leading){
                Image("coingecko")
                    .resizable()
                    .frame( height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This coingekko api is used for the getting data for the application. There is a issue with updating values with the near real time.")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical, 10)
            
            Link("Visit CoinGekko 🔗", destination: youtubeUrl)
            
        } header: {
            Text("CoinGekko")
        } footer: {
        }
    }
    
    var developerSection: some View{
        Section {
            VStack(alignment:.leading){
                Image("logo")
                    .resizable()
                    .frame(width:100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app is developed using swift ui and all the logic is written using swift programming language")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            .padding(.vertical, 10)
            
            Link("Visit the developer info 🔗", destination: coingekkoUrl)
            
        } header: {
            Text("Developer Info")
        } footer: {
        }
    }
    
    var applicationSection: some View{
        Section {
            Link("Terms and conditions", destination: defaultUrl)
            Link("Privacy policy", destination: defaultUrl)
            Link("Company Website", destination: defaultUrl)
            Link("Learn New", destination: defaultUrl)
        } header: {
            Text("Application")
        }

    }
}
