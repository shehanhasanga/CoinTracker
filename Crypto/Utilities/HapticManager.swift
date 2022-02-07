//
//  HapticManager.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-07.
//

import Foundation
import SwiftUI

class HapticManager{
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
    
}
