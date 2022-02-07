//
//  String.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import Foundation

extension String{
    var removingHTMLOccurances: String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
