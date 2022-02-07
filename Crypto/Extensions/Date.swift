//
//  Date.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import Foundation

extension Date {
    init(coinGekoString:String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.$$$Z"
        let date = formatter.date(from: coinGekoString) ?? Date()
        self.init(timeInterval:0, since: date)
    }
    
    private var shortDateFormatter : DateFormatter{
        var formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortDateFormatter.string(from: self)
    }
    
}
