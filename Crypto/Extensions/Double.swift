//
//  Double.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import Foundation

extension Double {
    
    private var currencyFormater2: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func currencyWith2Decimals() ->String {
        let number = NSNumber(value: self)
        return currencyFormater2.string(from: number) ?? "0.00"
    }
    
    
    private var currencyFormater6: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func currencyWith6Decimals() ->String {
        let number = NSNumber(value: self)
        return currencyFormater6.string(from: number) ?? "0.00"
    }
    
    func asNumerToString() -> String{
        return String(format: "%0.2f", self)
    }
    
    func asPercentageString() -> String {
        return asNumerToString() + "%"
    }
    
}
