//
//  UIApplication.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import Foundation
import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
