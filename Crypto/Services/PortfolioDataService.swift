//
//  PortfolioDataService.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import Foundation
import CoreData
import UIKit

class PortfolioDataService{
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    @Published var savedPortfolio: [PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("\(error)")
            }
            self.getPortfolio()
        }
    }
    
    func updatePortFoilioData(coin:CoinModel, amount:Double){
        if let entitySaved = savedPortfolio.first(where: { $0.coinID == coin.id }){
            if amount > 0 {
                update(entity: entitySaved, amount: amount)
            } else {
                delete(entity: entitySaved)
            }
        } else{
            addPortfolioEntity(coin: coin, amount: amount)
        }
    }
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do{
            savedPortfolio = try container.viewContext.fetch(request)
        }catch let error{
            print("\(error)")
        }
    }
    
    private func addPortfolioEntity(coin:CoinModel, amount:Double){
        let portfolioEntity = PortfolioEntity(context: container.viewContext)
        portfolioEntity.coinID = coin.id
        portfolioEntity.amount = amount
        applyChanges()
    }
    
    private func update(entity:PortfolioEntity, amount:Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity:PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private  func save(){
        do {
            try container.viewContext.save()
        }catch let error{
            print("error while saving data\(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
}
